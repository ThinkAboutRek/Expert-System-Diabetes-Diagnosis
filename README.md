Expert System for Diabetes Diagnosis
Overview
This project is an expert system designed to assist healthcare professionals in diagnosing diabetes mellitus. The system uses patient symptoms, medical history, and diagnostic test results to provide accurate and reliable diagnoses.

Features
Diagnoses Diabetes: Identifies diabetes based on fasting blood sugar (FBS) levels and HbA1c levels.
Categorizes Diabetes: Differentiates between Type 1, Type 2, and severe diabetes.
Identifies Pre-diabetes: Detects pre-diabetic conditions.
Assesses Risk: Evaluates high-risk patients based on weighted risk factors.
Interactive Input: Allows user input for patient data and provides real-time diagnoses.
Installation
To run this project, you need to have Prolog installed on your machine. SWI-Prolog is recommended. You can download it from SWI-Prolog website.

Usage
Clone the repository:

bash
Copy code
git clone https://github.com/ShayanBagheri/diabetes-expert-system.git
cd diabetes-expert-system
Load the Prolog file:

Start SWI-Prolog and load the main Prolog file:

prolog
Copy code
?- ['diabetes_expert_system.pl'].
Run the diagnosis system:

To start the interactive diagnosis system, run:

prolog
Copy code
?- input_and_diagnose.
Follow the prompts to enter patient data (name, symptoms, risk factors, and test levels).

System Components
Facts
symptom/2: Stores patient symptoms.
risk_factor/2: Stores patient risk factors.
fbs_level/2: Stores patient fasting blood sugar levels.
hba1c_level/2: Stores patient HbA1c levels.
Rules
diabetic/1: Diagnoses diabetes.
pre_diabetic/1: Diagnoses pre-diabetes.
severe_diabetic/1: Identifies severe diabetes cases.
diagnosis_type_1/1: Diagnoses Type 1 diabetes.
diagnosis_type_2/1: Diagnoses Type 2 diabetes.
diagnosis_high_risk/1: Identifies high-risk patients.
diagnosis_healthy/1: Identifies healthy patients.
Predicates
valid_fbs/1: Validates FBS levels.
valid_hba1c/1: Validates HbA1c levels.
weighted_risk/2: Calculates weighted risk based on risk factors.
Example
Here's an example of running the system and entering data for a new patient:

prolog
Copy code
?- input_and_diagnose.
Enter patient name:
new_patient
Enter a symptom or risk factor (or 'stop' to end):
frequent_urination
Enter a symptom or risk factor (or 'stop' to end):
stop
No more inputs, proceeding to enter test levels.
Enter fasting blood sugar level (FBS):
130
Enter HbA1c level:
6
new_patient diagnosis: pre_diabetic
Project Structure
diabetes_expert_system.pl: The main Prolog file containing the knowledge base and diagnostic rules.
Contributing
Contributions are welcome! If you have suggestions for improvements or new features, please create a pull request or open an issue.

License
This project is licensed under the MIT License. See the LICENSE file for more details.

Contact
For any questions or inquiries, please contact:

Name: Shayan Bagheri
Email: [Your Email]
