# Expert System for Diabetes Diagnosis

## Overview

This project is an expert system designed to assist healthcare professionals in diagnosing diabetes mellitus. The system uses patient symptoms, medical history, and diagnostic test results to provide accurate and reliable diagnoses.

## Features

- **Diagnoses Diabetes:** Identifies diabetes based on fasting blood sugar (FBS) levels and HbA1c levels.
- **Categorizes Diabetes:** Differentiates between Type 1, Type 2, and severe diabetes.
- **Identifies Pre-diabetes:** Detects pre-diabetic conditions.
- **Assesses Risk:** Evaluates high-risk patients based on weighted risk factors.
- **Interactive Input:** Allows user input for patient data and provides real-time diagnoses.

## Installation

To run this project, you need to have Prolog installed on your machine. SWI-Prolog is recommended. You can download it from [SWI-Prolog website](https://www.swi-prolog.org/Download.html).

## Usage

1. **Load the Prolog file:**
Start SWI-Prolog and load the main Prolog file:
   ```prolog
   ?- ['diabetes_expert_system.pl'].

2. **Run the diagnosis system:**
To start the interactive diagnosis system, run:

   ```prolog
   ?- input_and_diagnose.

