% --- Module Initialization for Dynamic Entries ---
:- dynamic symptom/2, risk_factor/2, fbs_level/2, hba1c_level/2.
:- dynamic fbs_threshold/1, hba1c_threshold/1, risk_weight/2.

% --- Threshold Values Initialization ---
fbs_threshold(126).
hba1c_threshold(6.5).

% --- Recognized Lists for Input Validation ---
recognized_symptoms([high_blood_sugar, frequent_urination, excessive_thirst, blurred_vision, fatigue, sudden_weight_loss, tingling_hands_feet, frequent_infections, slow_healing_wounds, nausea, dry_mouth]).
recognized_risks([overweight, age_above_45, family_history, sedentary_lifestyle, high_blood_pressure, gestational_diabetes_history, high_cholesterol]).

% --- Facts for Patient Symptoms ---
symptom(patient1, high_blood_sugar).
symptom(patient1, frequent_urination).
symptom(patient1, excessive_thirst).
symptom(patient1, blurred_vision).
symptom(patient1, fatigue).
symptom(patient1, sudden_weight_loss).

symptom(patient2, blurred_vision).
symptom(patient2, fatigue).
symptom(patient2, excessive_thirst).
symptom(patient2, tingling_hands_feet).

symptom(patient3, frequent_infections).
symptom(patient3, slow_healing_wounds).
symptom(patient3, sudden_weight_loss).
symptom(patient3, blurred_vision).
symptom(patient3, frequent_urination).

symptom(patient4, blurred_vision).
symptom(patient4, excessive_thirst).
symptom(patient4, slow_healing_wounds).
symptom(patient4, frequent_urination).

symptom(patient5, blurred_vision).
symptom(patient5, frequent_infections).
symptom(patient5, fatigue).
symptom(patient5, tingling_hands_feet).

% --- Facts for Patient Risk Factors ---
risk_factor(patient1, overweight).
risk_factor(patient1, age_above_45).
risk_factor(patient1, family_history).
risk_factor(patient1, sedentary_lifestyle).

risk_factor(patient2, age_above_45).
risk_factor(patient2, family_history).
risk_factor(patient2, high_blood_pressure).

risk_factor(patient3, sedentary_lifestyle).
risk_factor(patient3, gestational_diabetes_history).
risk_factor(patient3, high_blood_pressure).

risk_factor(patient4, overweight).
risk_factor(patient4, age_above_45).
risk_factor(patient4, family_history).

risk_factor(patient5, sedentary_lifestyle).
risk_factor(patient5, age_above_45).

% --- Blood Test Levels for Patients ---
fbs_level(patient1, 140).
fbs_level(patient2, 115).
fbs_level(patient3, 170).
fbs_level(patient4, 160).
fbs_level(patient5, 105).

hba1c_level(patient1, 7.2).
hba1c_level(patient2, 6.1).
hba1c_level(patient3, 8.1).
hba1c_level(patient4, 7.5).
hba1c_level(patient5, 5.9).

% --- Weight Mapping for Risk Factors ---
risk_weight(sedentary_lifestyle, 1.2).
risk_weight(family_history, 1.5).
risk_weight(high_blood_pressure, 1.3).
risk_weight(overweight, 1.1).
risk_weight(age_above_45, 1.1).
risk_weight(gestational_diabetes_history, 1.4).
risk_weight(high_cholesterol, 1.2).

% --- Weighted Risk Calculation for Probabilistic Reasoning ---
weighted_risk(Patient, Score) :-
    findall(Weight, (risk_factor(Patient, Risk), risk_weight(Risk, Weight)), Weights),
    sum_list(Weights, Score).

% --- Diagnostic Logic ---
valid_fbs(FBS) :-
    FBS > 50, FBS < 600.

valid_hba1c(HbA1c) :-
    HbA1c > 2, HbA1c < 20.

realistic_hba1c_for_diabetes(HbA1c) :-
    HbA1c >= 5.7.

realistic_hba1c_for_diabetes_or_prediabetes(HbA1c) :-
    HbA1c >= 5.7, HbA1c < 20.

diabetic(Patient) :-
    (fbs_level(Patient, FBS), valid_fbs(FBS), fbs_threshold(T_FBS), FBS >= T_FBS,
     hba1c_level(Patient, HbA1c), valid_hba1c(HbA1c), realistic_hba1c_for_diabetes(HbA1c));
    (hba1c_level(Patient, HbA1c), valid_hba1c(HbA1c), hba1c_threshold(T_HbA1c), HbA1c >= T_HbA1c).

pre_diabetic(Patient) :-
    (fbs_level(Patient, FBS), valid_fbs(FBS), fbs_threshold(T_FBS), FBS < T_FBS, FBS >= 100,
     hba1c_level(Patient, HbA1c), valid_hba1c(HbA1c), HbA1c < 6.5, HbA1c >= 5.7);
    (hba1c_level(Patient, HbA1c), valid_hba1c(HbA1c), hba1c_threshold(T_HbA1c), HbA1c < T_HbA1c, HbA1c >= 5.7).

severe_diabetic(Patient) :-
    diabetic(Patient),
    fbs_level(Patient, FBS), valid_fbs(FBS), FBS > 200.

diagnosis_type_1(Patient) :-
    diabetic(Patient),
    symptom(Patient, sudden_weight_loss).

diagnosis_type_2(Patient) :-
    diabetic(Patient),
    \+ diagnosis_type_1(Patient),
    (risk_factor(Patient, overweight);
     risk_factor(Patient, sedentary_lifestyle);
     risk_factor(Patient, age_above_45)).

diagnosis_high_risk(Patient) :-
    weighted_risk(Patient, Score),
    Score >= 2.5,
    ((fbs_level(Patient, FBS), valid_fbs(FBS), FBS < 126, FBS >= 100);
     (hba1c_level(Patient, HbA1c), valid_hba1c(HbA1c), HbA1c < 6.5, HbA1c >= 5.7)).

diagnosis_healthy(Patient) :-
    \+ diabetic(Patient),
    \+ pre_diabetic(Patient),
    \+ diagnosis_high_risk(Patient).

% --- Diagnostic Outcomes for Each Patient ---
diagnosis(Patient, severe_diabetic) :- severe_diabetic(Patient).
diagnosis(Patient, type_1_diabetes) :- diagnosis_type_1(Patient).
diagnosis(Patient, type_2_diabetes) :- diagnosis_type_2(Patient).
diagnosis(Patient, diabetic) :- diabetic(Patient).
diagnosis(Patient, pre_diabetic) :- pre_diabetic(Patient).
diagnosis(Patient, high_risk) :- diagnosis_high_risk(Patient).
diagnosis(Patient, healthy) :- diagnosis_healthy(Patient).

% --- User Interaction for Diagnosis ---
input_and_diagnose :-
    write('Enter patient name: '),
    read_line_to_string(user_input, PatientString),
    atom_string(Patient, PatientString),
    (   Patient \= 'stop'
    ->  repeat_until_stop(Patient),
        diagnosis(Patient, Diagnosis),
        format('~w diagnosis: ~w~n', [Patient, Diagnosis])
    ;   write('Stopping input.') ).

repeat_until_stop(Patient) :-
    write('Enter a symptom or risk factor (or \'stop\' to end): '),
    read_line_to_string(user_input, Input),
    atom_string(AtomInput, Input),
    (   AtomInput \= 'stop'
    ->  handle_input(Patient, AtomInput),
        repeat_until_stop(Patient)
    ;   write('No more inputs, proceeding to enter test levels.'), nl,
        enter_test_levels(Patient) ).

handle_input(Patient, Input) :-
    recognized_symptoms(Symptoms),
    recognized_risks(Risks),
    (   member(Input, Symptoms)
    ->  assertz(symptom(Patient, Input))
    ;   member(Input, Risks)
    ->  assertz(risk_factor(Patient, Input))
    ;   write('Invalid input. Please enter a recognized symptom or risk factor.'), nl).

enter_test_levels(Patient) :-
    ask_fbs_level(Patient),
    ask_hba1c_level(Patient).

ask_fbs_level(Patient) :-
    write('Enter fasting blood sugar level (FBS): '),
    read_line_to_string(user_input, FBSString),
    number_string(FBS, FBSString),
    (   number(FBS), valid_fbs(FBS)
    ->  assertz(fbs_level(Patient, FBS))
    ;   write('Invalid input. Please enter a valid numeric FBS level within a reasonable range.'), nl,
        ask_fbs_level(Patient) ).

ask_hba1c_level(Patient) :-
    write('Enter HbA1c level: '),
    read_line_to_string(user_input, HbA1cString),
    number_string(HbA1c, HbA1cString),
    (   number(HbA1c), valid_hba1c(HbA1c)
    ->  assertz(hba1c_level(Patient, HbA1c))
    ;   write('Invalid input. Please enter a valid numeric HbA1c level within a reasonable range.'), nl,
        ask_hba1c_level(Patient) ).

% --- Main Execution ---
% :- input_and_diagnose.
