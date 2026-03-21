import '../models/quiz_question.dart';

/// Quiz questions generated from episode transcripts.
/// 5 board-style multiple-choice questions per episode.
final Map<String, EpisodeQuiz> quizzes = {
  // ── Bioethics ──
  'Bioethics': const EpisodeQuiz(
    episodeTitle: 'Bioethics',
    questions: [
      QuizQuestion(
        question:
            'A patient with decisional capacity voluntarily asks their physician to make treatment decisions on their behalf. Which of the following best describes this situation?',
        options: [
          'A violation of patient autonomy',
          'An exercise of patient autonomy through delegation',
          'Evidence of lack of decisional capacity',
          'Paternalism by the physician',
        ],
        correctIndex: 1,
        explanation:
            'Autonomy includes the right to delegate decision-making. If a patient voluntarily and with understanding chooses to have someone else decide, that delegation itself is an exercise of autonomy, not a violation of it.',
      ),
      QuizQuestion(
        question:
            'Which of the following is determined by a judge, not a physician?',
        options: [
          'Decisional capacity',
          'Competence',
          'Informed consent',
          'Beneficence',
        ],
        correctIndex: 1,
        explanation:
            'Competence is a legal determination made by a judge. Physicians assess decisional capacity, which is a clinical assessment that is task-specific and time-dependent.',
      ),
      QuizQuestion(
        question:
            'A post-stroke patient with dysphagia is recommended a PEG tube but refuses, preferring oral intake despite aspiration risk. The physician respects this decision. Which ethical principles are in conflict?',
        options: [
          'Justice and non-maleficence',
          'Beneficence and autonomy',
          'Non-maleficence and justice',
          'Autonomy and competence',
        ],
        correctIndex: 1,
        explanation:
            'The PEG tube recommendation represents beneficence (preventing aspiration pneumonia), while the patient\'s refusal represents autonomy. In modern bioethics, autonomy generally prevails when the patient has capacity.',
      ),
      QuizQuestion(
        question:
            'An inpatient rehab unit has one bed remaining and two consults: a 25-year-old with TBI and high recovery potential, and a 95-year-old with end-stage dementia unlikely to make functional gains. Allocating the bed based on recovery potential is an example of which type of justice?',
        options: [
          'Non-comparative justice',
          'Distributive justice',
          'Comparative justice',
          'Procedural justice',
        ],
        correctIndex: 2,
        explanation:
            'Comparative justice involves weighing patients against each other based on need and potential benefit. Non-comparative justice applies equal rules regardless of individual need (e.g., insurance caps on therapy visits).',
      ),
      QuizQuestion(
        question:
            'Which of the following is NOT one of the four elements required for valid informed consent?',
        options: [
          'Patient competence or capacity',
          'Voluntary decision-making',
          'Written documentation signed by the patient',
          'Disclosure of important information',
        ],
        correctIndex: 2,
        explanation:
            'The four elements of informed consent are: (1) patient competence/capacity, (2) voluntary decision-making, (3) disclosure of important information, and (4) authorization to proceed. Written documentation is good practice but not one of the four required elements.',
      ),
    ],
  ),

  // ── Burns 1 ──
  'Burns 1': const EpisodeQuiz(
    episodeTitle: 'Burns 1',
    questions: [
      QuizQuestion(
        question:
            'In children under 2 years old, what is the most common cause of burn injuries?',
        options: [
          'Accidental scalding',
          'Electrical injury',
          'Child abuse',
          'Chemical exposure',
        ],
        correctIndex: 2,
        explanation:
            'In children under 2 years old, the majority of burns are the result of abuse. This is a critical clinical pearl — burn patterns such as immersion lines, stocking-glove patterns, or cigarette burns should raise immediate suspicion.',
      ),
      QuizQuestion(
        question:
            'Which zone in Jackson\'s burn wound model represents the primary target for acute burn management and can potentially be salvaged with proper resuscitation?',
        options: [
          'Zone of coagulation',
          'Zone of stasis',
          'Zone of hyperemia',
          'Zone of necrosis',
        ],
        correctIndex: 1,
        explanation:
            'The zone of stasis is the critical "battleground" — tissue is ischemic but cells are still alive. With proper fluid resuscitation, oxygenation, and infection control, this zone can recover. If management fails, it converts to the zone of coagulation (necrosis).',
      ),
      QuizQuestion(
        question:
            'A patient sustains a high-voltage electrical injury. Despite only a small entry wound on the hand, extensive deep tissue damage is found. Which concept best explains this finding?',
        options: [
          'The underestimation effect',
          'The iceberg effect',
          'Jackson\'s zone theory',
          'The biphasic response',
        ],
        correctIndex: 1,
        explanation:
            'The "iceberg effect" describes electrical burns: surface damage appears minimal but internal devastation (muscle, bone, nerves) can be massive. High-voltage current takes the most direct path and generates heat proportional to tissue resistance, with bone having the highest resistance.',
      ),
      QuizQuestion(
        question:
            'Which of the following is a recognized late complication specific to electrical burn injury?',
        options: [
          'Curling\'s ulcer',
          'Early-onset cataracts',
          'Marjolin\'s ulcer',
          'Hypertrophic scarring',
        ],
        correctIndex: 1,
        explanation:
            'The "electrical buzzwords" for board exams include: fractures (from violent tetanic muscle contractions), peripheral neuropathy, early-onset cataracts (from lens protein disruption), hearing loss, and heterotopic ossification (HO).',
      ),
      QuizQuestion(
        question:
            'In the acute phase of a major burn injury, which inflammatory mediator is primarily responsible for the massive capillary leak and fluid shift into the extravascular space?',
        options: [
          'Thromboxane',
          'Serotonin',
          'Histamine',
          'Epinephrine',
        ],
        correctIndex: 2,
        explanation:
            'After the initial vasoconstrictive phase (driven by epinephrine, serotonin, thromboxane), histamine causes massive vasodilation and extreme capillary permeability. This leads to protein and fluid shifting out of vessels, causing edema while intravascular volume crashes — resulting in hypovolemic shock.',
      ),
    ],
  ),

  // ── CVA 1 ──
  'Cerebrovascular Accident 1': const EpisodeQuiz(
    episodeTitle: 'Cerebrovascular Accident 1',
    questions: [
      QuizQuestion(
        question:
            'A patient presents with neurological deficits that completely resolve within 18 hours. How should this event be classified?',
        options: [
          'Completed stroke',
          'Reversible ischemic neurologic deficit (RIND)',
          'Transient ischemic attack (TIA)',
          'Minor stroke',
        ],
        correctIndex: 2,
        explanation:
            'Neurological deficits lasting less than 24 hours are classified as a TIA. The term RIND is obsolete and should never be selected on board exams. The modern binary classification is TIA (<24 hours) or stroke (≥24 hours).',
      ),
      QuizQuestion(
        question:
            'According to the ARIC study data, what is the approximate mortality rate at 1 year post-stroke?',
        options: [
          '10.5%',
          '21.2%',
          '40%',
          '58.4%',
        ],
        correctIndex: 1,
        explanation:
            'Per the ARIC (Atherosclerosis Risk in Communities) study: 30-day mortality is ~10.5%, 1-year is ~21.2%, 5-year is ~40%, and 24-year is ~58.4%. Board examiners frequently test this timeline.',
      ),
      QuizQuestion(
        question:
            'The apparent rise in stroke incidence in the early 1980s is best explained by which of the following?',
        options: [
          'Increased hypertension prevalence',
          'Decreased use of antihypertensives',
          'Widespread adoption of CT scanning',
          'Rising obesity rates',
        ],
        correctIndex: 2,
        explanation:
            'The ~17% spike in stroke incidence in the early 1980s is a data artifact caused by the widespread availability of CT scanners. Previously, many strokes were misdiagnosed as "sudden spells" or "senility." Better detection increased apparent incidence without a true increase in events.',
      ),
      QuizQuestion(
        question:
            'Stroke is currently ranked as which leading cause of death in the United States?',
        options: [
          'Third',
          'Fourth',
          'Fifth',
          'Sixth',
        ],
        correctIndex: 2,
        explanation:
            'Stroke is the 5th leading cause of death in the US, behind: (1) heart disease, (2) cancer, (3) chronic lower respiratory disease (COPD), and (4) accidents/unintentional injuries. It previously held the 3rd position.',
      ),
      QuizQuestion(
        question:
            'The dramatic 46% decline in stroke mortality from the 1950s to the 1970s is most strongly correlated with which development?',
        options: [
          'Introduction of tPA therapy',
          'Advent of effective antihypertensive medications',
          'Development of CT scanning',
          'Improved surgical thrombectomy techniques',
        ],
        correctIndex: 1,
        explanation:
            'The massive decline in stroke mortality from the 1950s-1970s correlates directly with the introduction of effective antihypertensive medications. Controlling blood pressure was the single greatest factor in reducing stroke deaths during this period.',
      ),
    ],
  ),

  // ── Cardiac Rehab 1 ──
  'Cardiac Rehab 1': const EpisodeQuiz(
    episodeTitle: 'Cardiac Rehab 1',
    questions: [
      QuizQuestion(
        question:
            'What is the 3-year survival rate for post-MI patients who participate in cardiac rehabilitation compared to non-participants?',
        options: [
          '85% vs 70%',
          '90% vs 75%',
          '95% vs 64%',
          '98% vs 80%',
        ],
        correctIndex: 2,
        explanation:
            'The 3-year survival rate for cardiac rehab participants is 95%, compared to only 64% for non-participants — a 31 percentage point difference. This is one of the most effective interventions in all of medicine.',
      ),
      QuizQuestion(
        question:
            'According to current guidelines, at what blood pressure threshold should treatment be initiated for cardiac rehab patients?',
        options: [
          '120/80 mmHg',
          '130/80 mmHg',
          '140/90 mmHg',
          '150/90 mmHg',
        ],
        correctIndex: 1,
        explanation:
            'The 2017 guidelines shifted the treatment threshold from 140/90 to the more aggressive target of 130/80 mmHg. This is a commonly tested board question as the guidelines have changed.',
      ),
      QuizQuestion(
        question:
            'What percentage of eligible candidates actually participate in cardiac rehabilitation programs?',
        options: [
          '5-10%',
          '11-20%',
          '30-40%',
          '50-60%',
        ],
        correctIndex: 1,
        explanation:
            'Despite undeniable survival benefits, only 11-20% of eligible candidates participate in cardiac rehab. This participation gap disproportionately affects older people, females, and non-white populations.',
      ),
      QuizQuestion(
        question:
            'Which of the following is NOT a non-modifiable risk factor for coronary artery disease?',
        options: [
          'Male sex',
          'Age (men >45, women >55)',
          'Diabetes mellitus',
          'Family history of premature CAD',
        ],
        correctIndex: 2,
        explanation:
            'Diabetes is a modifiable risk factor. Non-modifiable risk factors include: age (men >45, women >55), male sex, family history (male first-degree relative with CAD <55, female <65), and personal history of vascular disease.',
      ),
      QuizQuestion(
        question:
            'In the formal definition of cardiac rehabilitation, which component is often overlooked but specifically included as a goal?',
        options: [
          'Surgical recovery',
          'Vocational status',
          'Pharmaceutical management',
          'Diagnostic testing',
        ],
        correctIndex: 1,
        explanation:
            'The formal definition includes restoring optimal physiological, psychological, social, vocational, and emotional status. The vocational component is a key board concept — rehab aims to return patients to a productive role in society, not just survival.',
      ),
    ],
  ),

  // ── EDX 1 ──
  'Electrodiagnostic 1': const EpisodeQuiz(
    episodeTitle: 'Electrodiagnostic 1',
    questions: [
      QuizQuestion(
        question:
            'Electrodiagnostic medicine (EMG/NCS) is best described as which of the following?',
        options: [
          'A screening laboratory test',
          'An extension of the physical examination',
          'A replacement for clinical assessment',
          'A confirmatory imaging study',
        ],
        correctIndex: 1,
        explanation:
            'EDX is fundamentally an extension of the physical exam, not a lab test. The physician goes in with a clinical hypothesis based on history and exam, then uses EMG/NCS to confirm or refute that hypothesis. It answers: location, duration, severity, and prognosis.',
      ),
      QuizQuestion(
        question:
            'Where is the cell body of the lower motor neuron (anterior horn cell) located?',
        options: [
          'Dorsal root ganglion',
          'Posterior horn of the spinal cord',
          'Anterior (ventral) horn of the spinal cord',
          'Lateral horn of the spinal cord',
        ],
        correctIndex: 2,
        explanation:
            'The motor neuron cell body is located in the anterior (ventral) horn of the spinal cord gray matter. This is inside the CNS. In contrast, sensory neuron cell bodies are in the dorsal root ganglion, which is outside the CNS.',
      ),
      QuizQuestion(
        question:
            'The Henneman size principle explains which of the following?',
        options: [
          'Why larger nerve fibers conduct faster',
          'Why motor units are recruited from smallest to largest',
          'Why sensory neurons have faster conduction than motor neurons',
          'Why myelination increases conduction velocity',
        ],
        correctIndex: 1,
        explanation:
            'The Henneman size principle states that motor units are recruited from smallest to largest. This explains how you can both hold a baby gently (small motor units) and punch a bag forcefully (large motor units added) using the same muscles.',
      ),
      QuizQuestion(
        question:
            'Which factor is described as the single most common cause of misinterpretation in the electrodiagnostic laboratory?',
        options: [
          'Incorrect electrode placement',
          'Patient anxiety',
          'Temperature effects',
          'Electrical interference',
        ],
        correctIndex: 2,
        explanation:
            'Temperature is the single most common reason for misinterpretation in the EDX lab. Cool limb temperatures slow conduction velocities and can mimic neuropathy. This is an extremely high-yield board topic.',
      ),
      QuizQuestion(
        question:
            'EDX testing answers four key clinical questions. Which of the following is NOT one of them?',
        options: [
          'Location of the lesion',
          'Duration of the injury',
          'Etiology of the disease',
          'Prognosis for recovery',
        ],
        correctIndex: 2,
        explanation:
            'The four clinical questions answered by EDX are: (1) Location — root, plexus, nerve, or muscle; (2) Duration — acute, subacute, or chronic; (3) Severity — neuropraxia vs axonotmesis; (4) Prognosis — will it improve? Etiology/cause is determined by clinical correlation, not EDX alone.',
      ),
    ],
  ),

  // ── Burns 2 ──
  'Burns 2': const EpisodeQuiz(
    episodeTitle: 'Burns 2',
    questions: [
      QuizQuestion(
        question:
            'The Parkland formula for fluid resuscitation in burn patients calculates the 24-hour crystalloid requirement as:',
        options: [
          '2 mL × kg × %TBSA burned',
          '4 mL × kg × %TBSA burned',
          '6 mL × kg × %TBSA burned',
          '8 mL × kg × %TBSA burned',
        ],
        correctIndex: 1,
        explanation:
            'The Parkland formula is 4 mL × body weight (kg) × %TBSA burned using lactated Ringer\'s solution. Half is given in the first 8 hours, the remaining half over the next 16 hours. This is one of the most commonly tested burn formulas.',
      ),
      QuizQuestion(
        question:
            'Using the Rule of Nines in an adult, what percentage of total body surface area (TBSA) does the entire lower extremity represent?',
        options: [
          '9%',
          '14%',
          '18%',
          '36%',
        ],
        correctIndex: 2,
        explanation:
            'In the adult Rule of Nines: each lower extremity = 18% (front 9% + back 9%). Head = 9%, each upper extremity = 9%, anterior trunk = 18%, posterior trunk = 18%, perineum = 1%.',
      ),
      QuizQuestion(
        question:
            'A superficial partial-thickness (second-degree) burn is characterized by which of the following?',
        options: [
          'Dry, leathery, painless surface',
          'Red, painful surface with blisters',
          'Red, dry, painful surface without blisters',
          'Waxy white, painless surface',
        ],
        correctIndex: 1,
        explanation:
            'Superficial partial-thickness burns extend into the papillary dermis and present as red, painful, blistered wounds. First degree burns (superficial) are red and dry without blisters. Deep partial-thickness may appear waxy. Full thickness burns are dry, leathery, and painless.',
      ),
      QuizQuestion(
        question:
            'What is the target urine output used to guide adequacy of fluid resuscitation in adult burn patients?',
        options: [
          '0.25 mL/kg/hr',
          '0.5 mL/kg/hr',
          '1.0 mL/kg/hr',
          '2.0 mL/kg/hr',
        ],
        correctIndex: 1,
        explanation:
            'The target urine output for adult burn resuscitation is 0.5 mL/kg/hr (30-50 mL/hr in adults). For children, the target is higher at 1.0 mL/kg/hr. Urine output is the most reliable indicator of adequate resuscitation.',
      ),
      QuizQuestion(
        question:
            'Which type of burn injury is most commonly associated with the need to assess for rhabdomyolysis and monitor creatine kinase levels?',
        options: [
          'Thermal burns',
          'Chemical burns',
          'Radiation burns',
          'Electrical burns',
        ],
        correctIndex: 3,
        explanation:
            'Electrical burns cause massive deep muscle destruction due to internal heat generation along current pathways. This muscle breakdown (rhabdomyolysis) releases myoglobin and creatine kinase, risking acute renal failure. CK monitoring is essential.',
      ),
    ],
  ),

  // ── CVA 2 ──
  'Cerebrovascular Accident 2': const EpisodeQuiz(
    episodeTitle: 'Cerebrovascular Accident 2',
    questions: [
      QuizQuestion(
        question:
            'Which artery supplies the lateral surface of the cerebral hemisphere and is the most commonly affected vessel in ischemic stroke?',
        options: [
          'Anterior cerebral artery (ACA)',
          'Middle cerebral artery (MCA)',
          'Posterior cerebral artery (PCA)',
          'Basilar artery',
        ],
        correctIndex: 1,
        explanation:
            'The MCA is the most commonly affected artery in ischemic stroke. It supplies the lateral hemisphere including the motor and sensory cortex for face and upper extremity, Broca\'s area, and Wernicke\'s area.',
      ),
      QuizQuestion(
        question:
            'A patient presents with contralateral leg weakness and sensory loss with relative sparing of the face and arm. Which vascular territory is most likely affected?',
        options: [
          'Middle cerebral artery',
          'Anterior cerebral artery',
          'Posterior cerebral artery',
          'Posterior inferior cerebellar artery',
        ],
        correctIndex: 1,
        explanation:
            'The ACA supplies the medial surface of the hemisphere, which includes the motor and sensory representation of the lower extremity. ACA strokes classically present with contralateral leg weakness greater than arm or face.',
      ),
      QuizQuestion(
        question:
            'Homonymous hemianopia without motor deficits is most characteristic of a stroke in which vascular territory?',
        options: [
          'Anterior cerebral artery',
          'Middle cerebral artery',
          'Posterior cerebral artery',
          'Anterior choroidal artery',
        ],
        correctIndex: 2,
        explanation:
            'The PCA supplies the occipital lobe (visual cortex). PCA strokes classically present with contralateral homonymous hemianopia. Motor deficits are typically absent since the motor cortex is supplied by the ACA and MCA.',
      ),
      QuizQuestion(
        question:
            'In the Circle of Willis, which arteries connect the anterior and posterior circulation?',
        options: [
          'Anterior communicating arteries',
          'Posterior communicating arteries',
          'Ophthalmic arteries',
          'Lenticulostriate arteries',
        ],
        correctIndex: 1,
        explanation:
            'The posterior communicating arteries (PComm) connect the internal carotid arteries (anterior circulation) to the posterior cerebral arteries (posterior/vertebrobasilar circulation). The anterior communicating artery connects the two ACAs.',
      ),
      QuizQuestion(
        question:
            'Which type of ischemic stroke is caused by cardiogenic embolism and is associated with atrial fibrillation?',
        options: [
          'Large vessel atherosclerotic stroke',
          'Lacunar infarct',
          'Cardioembolic stroke',
          'Watershed infarct',
        ],
        correctIndex: 2,
        explanation:
            'Cardioembolic strokes account for approximately 20% of ischemic strokes and are strongly associated with atrial fibrillation. The embolus typically lodges in the MCA territory. Treatment includes anticoagulation rather than antiplatelet therapy alone.',
      ),
    ],
  ),

  // ── CVA 3 ──
  'Cerebrovascular Accident 3': const EpisodeQuiz(
    episodeTitle: 'Cerebrovascular Accident 3',
    questions: [
      QuizQuestion(
        question:
            'Wallenberg syndrome (lateral medullary syndrome) results from occlusion of which artery?',
        options: [
          'Anterior spinal artery',
          'Posterior inferior cerebellar artery (PICA)',
          'Anterior inferior cerebellar artery (AICA)',
          'Superior cerebellar artery',
        ],
        correctIndex: 1,
        explanation:
            'Wallenberg syndrome is caused by PICA occlusion affecting the lateral medulla. Classic findings include ipsilateral facial pain/temperature loss, contralateral body pain/temperature loss, dysphagia, hoarseness, vertigo, and ipsilateral Horner syndrome.',
      ),
      QuizQuestion(
        question:
            'A patient presents with ipsilateral facial numbness, contralateral body numbness, dysphagia, hoarseness, and Horner syndrome. What is the most likely diagnosis?',
        options: [
          'Weber syndrome',
          'Wallenberg syndrome',
          'Locked-in syndrome',
          'Benedikt syndrome',
        ],
        correctIndex: 1,
        explanation:
            'This is the classic presentation of Wallenberg (lateral medullary) syndrome. The crossed sensory findings (ipsilateral face, contralateral body) are pathognomonic and a favorite board question.',
      ),
      QuizQuestion(
        question:
            'Locked-in syndrome is caused by a lesion in which structure?',
        options: [
          'Lateral medulla',
          'Ventral pons',
          'Midbrain',
          'Thalamus',
        ],
        correctIndex: 1,
        explanation:
            'Locked-in syndrome results from a ventral pontine lesion (typically basilar artery occlusion). The patient is fully conscious but quadriplegic and mute, retaining only vertical eye movements and blinking. Cognition is completely intact.',
      ),
      QuizQuestion(
        question:
            'Weber syndrome is characterized by ipsilateral CN III palsy and contralateral hemiparesis. The lesion is located in which structure?',
        options: [
          'Pons',
          'Medulla',
          'Midbrain',
          'Cerebellum',
        ],
        correctIndex: 2,
        explanation:
            'Weber syndrome is a midbrain syndrome caused by damage to the cerebral peduncle and CN III fascicle. It produces ipsilateral oculomotor palsy (ptosis, dilated pupil, "down and out" eye) and contralateral hemiparesis.',
      ),
      QuizQuestion(
        question:
            'A lacunar infarct causing pure motor hemiparesis is most commonly located in which structure?',
        options: [
          'Thalamus',
          'Posterior limb of the internal capsule',
          'Caudate nucleus',
          'Cerebral cortex',
        ],
        correctIndex: 1,
        explanation:
            'Pure motor hemiparesis is the most common lacunar syndrome. The lesion is typically in the posterior limb of the internal capsule or basis pontis. It produces contralateral face, arm, and leg weakness without sensory, visual, or cognitive deficits.',
      ),
    ],
  ),

  // ── CVA 4 ──
  'Cerebrovascular Accident 4': const EpisodeQuiz(
    episodeTitle: 'Cerebrovascular Accident 4',
    questions: [
      QuizQuestion(
        question:
            'The window for IV tPA administration in acute ischemic stroke is within how many hours of symptom onset?',
        options: [
          '3 hours',
          '4.5 hours',
          '6 hours',
          '12 hours',
        ],
        correctIndex: 1,
        explanation:
            'IV tPA (alteplase) can be administered within 4.5 hours of symptom onset in eligible patients. The earlier it is given, the better the outcomes. Mechanical thrombectomy may extend the window to 24 hours for large vessel occlusions.',
      ),
      QuizQuestion(
        question:
            'Which standardized assessment tool is most commonly used to quantify stroke severity and guide treatment decisions?',
        options: [
          'Glasgow Coma Scale',
          'NIH Stroke Scale (NIHSS)',
          'Modified Rankin Scale',
          'Barthel Index',
        ],
        correctIndex: 1,
        explanation:
            'The NIH Stroke Scale (NIHSS) is the standard tool for quantifying stroke severity acutely. It scores 0-42, assessing consciousness, gaze, visual fields, facial palsy, motor function, ataxia, sensory, language, dysarthria, and extinction/inattention.',
      ),
      QuizQuestion(
        question:
            'Blood pressure management in the first 24 hours after tPA administration requires maintaining BP below which threshold?',
        options: [
          '140/90 mmHg',
          '160/100 mmHg',
          '180/105 mmHg',
          '220/120 mmHg',
        ],
        correctIndex: 2,
        explanation:
            'After tPA administration, blood pressure must be maintained below 180/105 mmHg to reduce the risk of hemorrhagic transformation. In patients NOT receiving tPA, permissive hypertension up to 220/120 is generally allowed.',
      ),
      QuizQuestion(
        question:
            'A patient with acute ischemic stroke who did NOT receive tPA has a blood pressure of 200/110 mmHg. What is the appropriate management?',
        options: [
          'Immediate aggressive blood pressure lowering',
          'Permissive hypertension — do not treat',
          'Lower blood pressure to 140/90',
          'Administer tPA',
        ],
        correctIndex: 1,
        explanation:
            'In patients with acute ischemic stroke who did not receive tPA, permissive hypertension is allowed up to 220/120 mmHg. The elevated BP helps maintain cerebral perfusion to the ischemic penumbra. Only treat if BP exceeds 220/120.',
      ),
      QuizQuestion(
        question:
            'Which functional outcome measure classifies disability on a scale of 0 (no symptoms) to 6 (death) and is the primary endpoint in most stroke trials?',
        options: [
          'Barthel Index',
          'FIM (Functional Independence Measure)',
          'Modified Rankin Scale (mRS)',
          'NIH Stroke Scale',
        ],
        correctIndex: 2,
        explanation:
            'The Modified Rankin Scale (mRS) is the primary outcome measure in most stroke clinical trials. It ranges from 0 (no symptoms) to 6 (death), with scores of 0-2 generally considered a favorable outcome.',
      ),
    ],
  ),

  // ── CVA 5 ──
  'Cerebrovascular Accident 5': const EpisodeQuiz(
    episodeTitle: 'Cerebrovascular Accident 5',
    questions: [
      QuizQuestion(
        question:
            'Post-stroke shoulder pain occurs in approximately what percentage of hemiplegic patients?',
        options: [
          '10-20%',
          '30-40%',
          '50-80%',
          '90-100%',
        ],
        correctIndex: 2,
        explanation:
            'Hemiplegic shoulder pain is extremely common, occurring in approximately 50-80% of stroke patients. It is one of the most significant barriers to rehabilitation progress and has multiple contributing factors.',
      ),
      QuizQuestion(
        question:
            'Which of the following is the most important initial intervention to prevent hemiplegic shoulder subluxation?',
        options: [
          'Aggressive passive range of motion',
          'Proper positioning and support of the affected arm',
          'Corticosteroid injection',
          'Surgical repair',
        ],
        correctIndex: 1,
        explanation:
            'Proper positioning and arm support (using arm troughs, lap boards, or slings when upright) is the most important initial intervention. Aggressive passive ROM, particularly overhead pulleys, should be avoided as they can worsen impingement and pain.',
      ),
      QuizQuestion(
        question:
            'Overhead pulleys for hemiplegic shoulder rehabilitation are generally considered:',
        options: [
          'First-line therapy for shoulder subluxation',
          'Beneficial for increasing ROM',
          'Contraindicated due to risk of impingement and pain',
          'Only appropriate for flaccid stage',
        ],
        correctIndex: 2,
        explanation:
            'Overhead pulleys are generally contraindicated in hemiplegic shoulders. They can cause impingement, rotator cuff injury, and worsen pain because the patient cannot control the affected arm during the motion.',
      ),
      QuizQuestion(
        question:
            'Brunnstrom stages of motor recovery describe the progression from flaccidity through spasticity to voluntary movement. What does Stage 3 represent?',
        options: [
          'Flaccidity with no voluntary movement',
          'Spasticity appears, synergy patterns emerge',
          'Spasticity peaks, voluntary synergy patterns',
          'Spasticity decreases, isolated movements emerge',
        ],
        correctIndex: 2,
        explanation:
            'Brunnstrom Stage 3 is characterized by peak spasticity and the ability to voluntarily initiate synergy patterns. Stage 1 = flaccidity, Stage 2 = spasticity begins, Stage 3 = spasticity peaks with voluntary synergies, Stage 4 = spasticity decreases with some isolated movement.',
      ),
      QuizQuestion(
        question:
            'Central post-stroke pain (thalamic pain syndrome) is best treated initially with which class of medications?',
        options: [
          'NSAIDs',
          'Opioids',
          'Anticonvulsants or tricyclic antidepressants',
          'Muscle relaxants',
        ],
        correctIndex: 2,
        explanation:
            'Central post-stroke pain (Dejerine-Roussy syndrome) is a neuropathic pain condition best treated with anticonvulsants (gabapentin, pregabalin) or tricyclic antidepressants (amitriptyline). It does not respond well to NSAIDs or opioids.',
      ),
    ],
  ),

  // ── CVA 6 ──
  'Cerebrovascular Accident 6': const EpisodeQuiz(
    episodeTitle: 'Cerebrovascular Accident 6',
    questions: [
      QuizQuestion(
        question:
            'The FIM (Functional Independence Measure) scores range from:',
        options: [
          '0 to 100',
          '7 to 49',
          '18 to 126',
          '0 to 42',
        ],
        correctIndex: 2,
        explanation:
            'The FIM has 18 items, each scored 1-7, giving a total range of 18 (total dependence) to 126 (complete independence). It measures motor (13 items, max 91) and cognitive (5 items, max 35) domains.',
      ),
      QuizQuestion(
        question:
            'In stroke rehabilitation, the strongest predictor of functional outcome is:',
        options: [
          'Patient age',
          'Initial stroke severity',
          'Time to rehabilitation admission',
          'Type of stroke (ischemic vs hemorrhagic)',
        ],
        correctIndex: 1,
        explanation:
            'Initial stroke severity (as measured by NIHSS or initial functional status) is the strongest predictor of functional outcome. While age and time to rehab admission matter, the severity of the initial neurological deficit is most predictive.',
      ),
      QuizQuestion(
        question:
            'The optimal time to begin inpatient rehabilitation after stroke is:',
        options: [
          'Within 24 hours',
          'Within 72 hours',
          'As soon as medically stable',
          'After 2 weeks of acute care',
        ],
        correctIndex: 2,
        explanation:
            'Current guidelines recommend beginning inpatient rehabilitation as soon as the patient is medically stable and can participate in at least 3 hours of therapy per day. Earlier initiation is associated with better outcomes, but the patient must be stable.',
      ),
      QuizQuestion(
        question:
            'Which of the following is a criterion for admission to an acute inpatient rehabilitation facility (IRF)?',
        options: [
          'Patient requires one therapy discipline only',
          'Patient can tolerate 3 hours of therapy per day',
          'Patient requires only nursing care',
          'Patient has completed all acute medical treatment',
        ],
        correctIndex: 1,
        explanation:
            'IRF admission requires that the patient can participate in and benefit from at least 3 hours of therapy per day (the "3-hour rule"), needs at least 2 therapy disciplines, requires physician supervision, and is expected to make functional improvement.',
      ),
      QuizQuestion(
        question:
            'A stroke patient demonstrates neglect of the left side, anosognosia, and impaired spatial awareness. The lesion is most likely in which hemisphere?',
        options: [
          'Left (dominant)',
          'Right (non-dominant)',
          'Bilateral',
          'Posterior fossa',
        ],
        correctIndex: 1,
        explanation:
            'Left-sided neglect, anosognosia (denial of deficit), and impaired spatial awareness are classic findings of right (non-dominant) hemisphere strokes. Left hemisphere strokes more commonly produce aphasia. Neglect is a significant predictor of poorer rehabilitation outcomes.',
      ),
    ],
  ),

  // ── Cardiac Rehab 2 ──
  'Cardiac Rehab 2': const EpisodeQuiz(
    episodeTitle: 'Cardiac Rehab 2',
    questions: [
      QuizQuestion(
        question:
            'VO2 max represents which of the following?',
        options: [
          'Maximum oxygen consumption of the heart muscle',
          'Maximum total body oxygen consumption during exercise',
          'Resting oxygen consumption',
          'Oxygen saturation at peak exercise',
        ],
        correctIndex: 1,
        explanation:
            'VO2 max is the maximum total body oxygen consumption. It represents the body\'s aerobic capacity and is determined primarily by cardiac output and peripheral oxygen extraction. It is distinct from MVO2, which is myocardial oxygen consumption.',
      ),
      QuizQuestion(
        question:
            'One metabolic equivalent (MET) is defined as oxygen consumption of:',
        options: [
          '1.5 mL/kg/min',
          '3.5 mL/kg/min',
          '5.0 mL/kg/min',
          '7.0 mL/kg/min',
        ],
        correctIndex: 1,
        explanation:
            '1 MET = 3.5 mL O2/kg/min, which represents resting metabolic rate. Activity intensity is expressed in METs: light activity = 2-3 METs, moderate = 3-6 METs, vigorous = >6 METs. This is a fundamental board concept.',
      ),
      QuizQuestion(
        question:
            'The Rate Pressure Product (RPP) is calculated as:',
        options: [
          'Heart rate × Stroke volume',
          'Systolic BP × Heart rate',
          'Diastolic BP × Heart rate',
          'Cardiac output × Total peripheral resistance',
        ],
        correctIndex: 1,
        explanation:
            'RPP = Systolic BP × Heart rate. It is the best non-invasive estimate of myocardial oxygen demand (MVO2). An RPP >25,000 generally indicates significant myocardial workload and is used to set exercise limits.',
      ),
      QuizQuestion(
        question:
            'During a graded exercise test, which of the following is an absolute indication to stop the test?',
        options: [
          'Systolic BP reaching 200 mmHg',
          'Drop in systolic BP >10 mmHg despite increasing workload',
          'Rating of perceived exertion reaching 15',
          'Heart rate reaching 85% of predicted maximum',
        ],
        correctIndex: 1,
        explanation:
            'A drop in systolic BP >10 mmHg from baseline despite increasing workload is an absolute indication to stop exercise testing, as it may indicate pump failure, severe ischemia, or outflow obstruction.',
      ),
      QuizQuestion(
        question:
            'Using the Karvonen formula, target heart rate during exercise is calculated using:',
        options: [
          'A percentage of maximum heart rate',
          'Heart rate reserve (HRmax - HRrest) plus resting heart rate',
          'Maximum heart rate minus age',
          'Resting heart rate plus 20 bpm',
        ],
        correctIndex: 1,
        explanation:
            'The Karvonen formula: Target HR = [(HRmax - HRrest) × %intensity] + HRrest. It uses heart rate reserve, which accounts for resting heart rate and is more accurate than simply using a percentage of max HR.',
      ),
    ],
  ),

  // ── Cardiac Rehab 3 ──
  'Cardiac Rehab 3': const EpisodeQuiz(
    episodeTitle: 'Cardiac Rehab 3',
    questions: [
      QuizQuestion(
        question:
            'Phase I cardiac rehabilitation takes place during which period?',
        options: [
          'Outpatient, 2-12 weeks post-event',
          'Inpatient, during acute hospitalization',
          'Long-term community maintenance',
          'Pre-surgical optimization',
        ],
        correctIndex: 1,
        explanation:
            'Phase I is inpatient cardiac rehab during acute hospitalization. Phase II is supervised outpatient (2-12 weeks). Phase III is a transitional monitored program. Phase IV is lifelong maintenance.',
      ),
      QuizQuestion(
        question:
            'During Phase I cardiac rehab, activities are typically limited to which MET level?',
        options: [
          '1-2 METs',
          '3-5 METs',
          '5-7 METs',
          '7-10 METs',
        ],
        correctIndex: 0,
        explanation:
            'Phase I activities are limited to 1-2 METs (e.g., self-care, slow walking, sitting in a chair). The focus is on preventing deconditioning, patient education, and safe mobilization while still in the acute setting.',
      ),
      QuizQuestion(
        question:
            'Which of the following is a Medicare-covered diagnosis for cardiac rehabilitation?',
        options: [
          'Atrial fibrillation',
          'Peripheral artery disease',
          'Stable angina pectoris',
          'Aortic aneurysm',
        ],
        correctIndex: 2,
        explanation:
            'Medicare-covered diagnoses for cardiac rehab include: MI within 12 months, CABG, stable angina, heart valve repair/replacement, PCI (stenting/angioplasty), heart or heart-lung transplant, and stable chronic heart failure with EF ≤35%.',
      ),
      QuizQuestion(
        question:
            'The ejection fraction cutoff for heart failure patients to qualify for Medicare-covered cardiac rehabilitation is:',
        options: [
          '≤25%',
          '≤30%',
          '≤35%',
          '≤40%',
        ],
        correctIndex: 2,
        explanation:
            'Stable chronic heart failure patients with an ejection fraction of ≤35% qualify for Medicare-covered cardiac rehabilitation. This specific threshold is a commonly tested board question.',
      ),
      QuizQuestion(
        question:
            'How many cardiac rehabilitation sessions does Medicare typically reimburse?',
        options: [
          '12 sessions',
          '24 sessions',
          '36 sessions',
          '48 sessions',
        ],
        correctIndex: 2,
        explanation:
            'Medicare reimburses up to 36 sessions of cardiac rehabilitation, with the possibility of an additional 36 sessions if medically necessary. Studies show that attending all 36 sessions is associated with significantly better outcomes than partial attendance.',
      ),
    ],
  ),

  // ── Cardiac Rehab 4 ──
  'Cardiac Rehab 4': const EpisodeQuiz(
    episodeTitle: 'Cardiac Rehab 4',
    questions: [
      QuizQuestion(
        question:
            'The Borg Rating of Perceived Exertion (RPE) scale ranges from:',
        options: [
          '0 to 10',
          '1 to 20',
          '6 to 20',
          '1 to 100',
        ],
        correctIndex: 2,
        explanation:
            'The classic Borg RPE scale ranges from 6 to 20, designed to roughly correlate with heart rate when multiplied by 10 (e.g., RPE 12 ≈ HR 120). Target exercise intensity in cardiac rehab is typically RPE 11-14 ("fairly light" to "somewhat hard").',
      ),
      QuizQuestion(
        question:
            'Which of the following activities requires approximately 3-5 METs?',
        options: [
          'Resting in bed',
          'Walking 3-4 mph on level ground',
          'Running at 6 mph',
          'Competitive swimming',
        ],
        correctIndex: 1,
        explanation:
            'Walking at 3-4 mph is approximately 3-5 METs (moderate intensity). Resting = 1 MET, light walking = 2-3 METs, running = 8+ METs. Understanding MET levels for common activities is essential for exercise prescription.',
      ),
      QuizQuestion(
        question:
            'Which of the following is an absolute contraindication to exercise testing?',
        options: [
          'Controlled hypertension',
          'Unstable angina not stabilized by medical therapy',
          'Mild aortic stenosis',
          'History of prior MI more than 6 months ago',
        ],
        correctIndex: 1,
        explanation:
            'Absolute contraindications to exercise testing include: unstable angina, acute MI (within 2 days), uncontrolled symptomatic heart failure, active endocarditis/myocarditis/pericarditis, severe symptomatic aortic stenosis, and acute aortic dissection.',
      ),
      QuizQuestion(
        question:
            'During cardiac rehab exercise, patients on beta-blockers will demonstrate which of the following?',
        options: [
          'Exaggerated heart rate response',
          'Normal heart rate response',
          'Blunted heart rate response',
          'Irregular heart rate response',
        ],
        correctIndex: 2,
        explanation:
            'Beta-blockers blunt the heart rate response to exercise. This means heart rate alone cannot be used reliably to gauge exercise intensity. In these patients, RPE (Borg scale) and the talk test become more important measures of exercise intensity.',
      ),
      QuizQuestion(
        question:
            'Why is using a bedpan considered more physiologically stressful than using a bedside commode in cardiac patients?',
        options: [
          'Bedpans require more upper extremity effort',
          'The Valsalva maneuver and isometric strain are greater with a bedpan',
          'Bedpans increase heart rate more than walking',
          'Commodes require longer time',
        ],
        correctIndex: 1,
        explanation:
            'Using a bedpan requires more isometric straining and often triggers a Valsalva maneuver, significantly increasing myocardial oxygen demand. A bedside commode is physiologically safer because it allows more natural positioning and less straining.',
      ),
    ],
  ),

  // ── Biostats ──
  'Biostatistics': const EpisodeQuiz(
    episodeTitle: 'Biostatistics',
    questions: [
      QuizQuestion(
        question:
            'A screening test has 95% sensitivity. This means:',
        options: [
          '95% of those who test positive truly have the disease',
          '95% of those who have the disease will test positive',
          '5% of healthy individuals will test positive',
          '95% of all test results are correct',
        ],
        correctIndex: 1,
        explanation:
            'Sensitivity = true positive rate = proportion of people WITH the disease who test positive. A sensitivity of 95% means the test catches 95% of true cases. High sensitivity is important for screening (SnNOut: Sensitive test, Negative result, rules Out disease).',
      ),
      QuizQuestion(
        question:
            'A test with high specificity is most useful for:',
        options: [
          'Screening large populations',
          'Ruling out disease when negative',
          'Confirming disease when positive',
          'Estimating disease prevalence',
        ],
        correctIndex: 2,
        explanation:
            'High specificity means few false positives (SpPIn: Specific test, Positive result, rules In disease). Specific tests are best for confirming a diagnosis. Sensitive tests are best for screening/ruling out disease.',
      ),
      QuizQuestion(
        question:
            'A Type I error (alpha error) occurs when:',
        options: [
          'You fail to reject a false null hypothesis',
          'You reject a true null hypothesis',
          'The sample size is too small',
          'The confidence interval is too wide',
        ],
        correctIndex: 1,
        explanation:
            'Type I error (alpha/false positive) = rejecting a true null hypothesis (finding a difference when none exists). Type II error (beta/false negative) = failing to reject a false null hypothesis (missing a real difference). Standard alpha = 0.05.',
      ),
      QuizQuestion(
        question:
            'Power of a study is defined as:',
        options: [
          'The probability of a Type I error',
          'The probability of finding a difference when one truly exists',
          'The size of the treatment effect',
          'The confidence level of the study',
        ],
        correctIndex: 1,
        explanation:
            'Power = 1 - beta = the probability of correctly rejecting a false null hypothesis (detecting a real effect). Standard power is 0.80 (80%). Power is increased by: larger sample size, larger effect size, and higher alpha level.',
      ),
      QuizQuestion(
        question:
            'In an intention-to-treat analysis, patients who drop out of the treatment group are:',
        options: [
          'Excluded from the analysis',
          'Analyzed as part of the treatment group regardless',
          'Moved to the control group',
          'Analyzed separately',
        ],
        correctIndex: 1,
        explanation:
            'Intention-to-treat (ITT) analysis keeps all randomized participants in their original assigned groups regardless of compliance, withdrawal, or crossover. It preserves the benefits of randomization and provides a more conservative, real-world estimate of treatment effect.',
      ),
    ],
  ),

  // ── Cancer Rehab 1 ──
  'Cancer Rehab 1': const EpisodeQuiz(
    episodeTitle: 'Cancer Rehab 1',
    questions: [
      QuizQuestion(
        question:
            'According to Dietz classification, which type of cancer rehabilitation focuses on patients with known cancer and anticipated deficits from treatment?',
        options: [
          'Preventive',
          'Restorative',
          'Supportive',
          'Palliative',
        ],
        correctIndex: 0,
        explanation:
            'Dietz classification: Preventive = anticipating and preventing deficits before/during treatment. Restorative = returning to prior function after treatment. Supportive = maximizing function with ongoing disease. Palliative = comfort and function at end of life.',
      ),
      QuizQuestion(
        question:
            'What is the most common cancer in men in the United States?',
        options: [
          'Lung cancer',
          'Colorectal cancer',
          'Prostate cancer',
          'Bladder cancer',
        ],
        correctIndex: 2,
        explanation:
            'Prostate cancer is the most commonly diagnosed cancer in men. Lung cancer remains the leading cause of cancer death in both men and women. Breast cancer is the most common cancer in women.',
      ),
      QuizQuestion(
        question:
            'Cancer-related fatigue is the most common symptom reported by cancer patients. Which of the following best describes its characteristics?',
        options: [
          'It resolves with adequate sleep',
          'It is proportional to activity level',
          'It is persistent and not relieved by rest',
          'It only occurs during active treatment',
        ],
        correctIndex: 2,
        explanation:
            'Cancer-related fatigue is persistent, distressing, and not proportional to activity level or relieved by rest. It is the most common symptom in cancer patients and can persist long after treatment ends. Exercise is the best-studied intervention.',
      ),
      QuizQuestion(
        question:
            'Which chemotherapy class is most commonly associated with peripheral neuropathy?',
        options: [
          'Alkylating agents',
          'Platinum-based agents and taxanes',
          'Antimetabolites',
          'Hormonal agents',
        ],
        correctIndex: 1,
        explanation:
            'Platinum compounds (cisplatin, oxaliplatin) and taxanes (paclitaxel, docetaxel) are the most common causes of chemotherapy-induced peripheral neuropathy (CIPN). It typically presents as a distal, symmetric, sensory-predominant neuropathy in a stocking-glove distribution.',
      ),
      QuizQuestion(
        question:
            'Lymphedema following axillary lymph node dissection for breast cancer most commonly affects:',
        options: [
          'The ipsilateral lower extremity',
          'The contralateral upper extremity',
          'The ipsilateral upper extremity',
          'Both upper extremities',
        ],
        correctIndex: 2,
        explanation:
            'Lymphedema after axillary lymph node dissection affects the ipsilateral upper extremity. Risk increases with the number of nodes removed, radiation therapy, obesity, and infection. Complete decongestive therapy (CDT) is the gold standard treatment.',
      ),
    ],
  ),

  // ── Cancer Rehab 2 ──
  'Cancer Rehab 2': const EpisodeQuiz(
    episodeTitle: 'Cancer Rehab 2',
    questions: [
      QuizQuestion(
        question:
            'Radiation fibrosis syndrome most commonly affects which tissues?',
        options: [
          'Bone marrow only',
          'Skin, muscle, and nerve in the radiation field',
          'The entire body systemically',
          'Only lymphatic tissue',
        ],
        correctIndex: 1,
        explanation:
            'Radiation fibrosis is a progressive process affecting skin, subcutaneous tissue, muscle, and nerves within the radiation field. It can cause contractures, neuropathy, and lymphedema. It may present months to years after radiation therapy.',
      ),
      QuizQuestion(
        question:
            'The cornerstone treatment for cancer-related lymphedema is:',
        options: [
          'Diuretic therapy',
          'Surgical debulking',
          'Complete decongestive therapy (CDT)',
          'Compression stockings alone',
        ],
        correctIndex: 2,
        explanation:
            'Complete decongestive therapy (CDT) is the gold standard for lymphedema management. It includes manual lymphatic drainage, compression bandaging, exercise, and skin care. Diuretics are generally not effective for lymphedema.',
      ),
      QuizQuestion(
        question:
            'A patient with a history of breast cancer and axillary node dissection should avoid which of the following in the affected arm?',
        options: [
          'Gentle exercise',
          'Blood pressure measurement and venipuncture',
          'Wearing loose clothing',
          'Elevation of the extremity',
        ],
        correctIndex: 1,
        explanation:
            'Blood pressure measurement, venipuncture, and IV access should be avoided in the affected arm after axillary lymph node dissection to reduce lymphedema risk. Gentle exercise and elevation are encouraged.',
      ),
      QuizQuestion(
        question:
            'Which paraneoplastic syndrome is associated with proximal muscle weakness that improves with repeated use?',
        options: [
          'Myasthenia gravis',
          'Lambert-Eaton myasthenic syndrome',
          'Dermatomyositis',
          'Polymyositis',
        ],
        correctIndex: 1,
        explanation:
            'Lambert-Eaton syndrome is a paraneoplastic condition (commonly associated with small cell lung cancer) featuring proximal weakness that characteristically improves with repeated use (opposite of myasthenia gravis). It involves antibodies against presynaptic voltage-gated calcium channels.',
      ),
      QuizQuestion(
        question:
            'Pathologic fractures in cancer patients most commonly occur in which bone?',
        options: [
          'Humerus',
          'Femur',
          'Vertebra',
          'Pelvis',
        ],
        correctIndex: 1,
        explanation:
            'The femur is the most common site for pathologic fractures due to metastatic disease. The proximal femur bears significant weight-loading forces. Prophylactic fixation should be considered when >50% of cortical bone is destroyed.',
      ),
    ],
  ),

  // ── Cancer Rehab 3 ──
  'Cancer Rehab 3': const EpisodeQuiz(
    episodeTitle: 'Cancer Rehab 3',
    questions: [
      QuizQuestion(
        question:
            'Brain tumor patients undergoing rehabilitation should be monitored for which common complication?',
        options: [
          'Hepatotoxicity',
          'Seizures',
          'Renal failure',
          'Pulmonary embolism',
        ],
        correctIndex: 1,
        explanation:
            'Seizures are a very common complication in brain tumor patients (occurring in 20-40% of cases). Antiepileptic medications are frequently required. Therapy programs should be adjusted to ensure patient safety during activities.',
      ),
      QuizQuestion(
        question:
            'The Karnofsky Performance Status scale ranges from:',
        options: [
          '0 to 5',
          '0 to 10',
          '0 to 100',
          '1 to 7',
        ],
        correctIndex: 2,
        explanation:
            'The Karnofsky Performance Status (KPS) scale ranges from 0 (dead) to 100 (normal, no complaints). It is widely used in oncology to assess functional status. A KPS of 70+ generally indicates ability to care for self; below 50 indicates need for significant assistance.',
      ),
      QuizQuestion(
        question:
            'Exercise during cancer treatment has been shown to:',
        options: [
          'Increase risk of metastasis',
          'Have no effect on fatigue',
          'Reduce fatigue and improve quality of life',
          'Be contraindicated during chemotherapy',
        ],
        correctIndex: 2,
        explanation:
            'Exercise during cancer treatment is the best-studied intervention for cancer-related fatigue. It reduces fatigue, improves quality of life, maintains muscle mass, and may improve treatment tolerance. It is not contraindicated during chemotherapy in most patients.',
      ),
      QuizQuestion(
        question:
            'Spinal cord compression from metastatic cancer most commonly involves which region?',
        options: [
          'Cervical spine',
          'Thoracic spine',
          'Lumbar spine',
          'Sacral spine',
        ],
        correctIndex: 1,
        explanation:
            'Metastatic spinal cord compression most commonly occurs in the thoracic spine (approximately 70% of cases), followed by the lumbosacral spine, then cervical spine. This reflects the relative volume of the thoracic spine and common metastatic spread patterns.',
      ),
      QuizQuestion(
        question:
            'Which cancers most commonly metastasize to bone?',
        options: [
          'Lung, liver, pancreas, colon',
          'Breast, prostate, lung, kidney, thyroid',
          'Brain, ovarian, gastric, esophageal',
          'Melanoma, sarcoma, lymphoma, leukemia',
        ],
        correctIndex: 1,
        explanation:
            'The cancers most likely to metastasize to bone can be remembered with the mnemonic "BLT with a Kosher Pickle" — Breast, Lung, Thyroid, Kidney, Prostate. These account for the vast majority of skeletal metastases.',
      ),
    ],
  ),

  // ── EDX 2 ──
  'Electrodiagnostic 2': const EpisodeQuiz(
    episodeTitle: 'Electrodiagnostic 2',
    questions: [
      QuizQuestion(
        question:
            'Saltatory conduction refers to:',
        options: [
          'Continuous propagation of action potentials along unmyelinated fibers',
          'Action potentials jumping from one node of Ranvier to the next',
          'Conduction across the neuromuscular junction',
          'Retrograde conduction in sensory nerves',
        ],
        correctIndex: 1,
        explanation:
            'Saltatory conduction is the process by which action potentials "jump" between nodes of Ranvier in myelinated nerves. This dramatically increases conduction velocity (up to 120 m/s) and reduces energy expenditure compared to continuous conduction in unmyelinated fibers.',
      ),
      QuizQuestion(
        question:
            'The resting membrane potential of a typical neuron is approximately:',
        options: [
          '-40 mV',
          '-55 mV',
          '-70 mV',
          '-90 mV',
        ],
        correctIndex: 2,
        explanation:
            'The resting membrane potential is approximately -70 mV, maintained primarily by the Na+/K+ ATPase pump (3 Na+ out, 2 K+ in) and potassium leak channels. This negative intracellular charge is essential for action potential generation.',
      ),
      QuizQuestion(
        question:
            'During depolarization of an action potential, which ion channels open first?',
        options: [
          'Potassium channels',
          'Calcium channels',
          'Chloride channels',
          'Sodium channels',
        ],
        correctIndex: 3,
        explanation:
            'Voltage-gated sodium channels open first during depolarization, allowing rapid Na+ influx that drives the membrane potential from -70 mV toward +30 mV. Potassium channels open later for repolarization. This sequence is the basis of the action potential.',
      ),
      QuizQuestion(
        question:
            'The neuromuscular junction uses which neurotransmitter?',
        options: [
          'Norepinephrine',
          'GABA',
          'Glutamate',
          'Acetylcholine',
        ],
        correctIndex: 3,
        explanation:
            'Acetylcholine (ACh) is the neurotransmitter at the neuromuscular junction. It is released from the presynaptic terminal, crosses the synaptic cleft, and binds to nicotinic receptors on the motor end plate, triggering muscle contraction.',
      ),
      QuizQuestion(
        question:
            'Cooling a nerve will cause which of the following changes on nerve conduction studies?',
        options: [
          'Increased conduction velocity and decreased amplitude',
          'Decreased conduction velocity and increased amplitude',
          'No change in conduction parameters',
          'Decreased conduction velocity and decreased amplitude',
        ],
        correctIndex: 1,
        explanation:
            'Cool temperatures slow sodium channel kinetics, prolonging the action potential duration. This decreases conduction velocity but paradoxically increases amplitude (the prolonged action potential allows more temporal summation). This can mimic demyelinating neuropathy — always check limb temperature!',
      ),
    ],
  ),

  // ── MSK Ankle 1 ──
  'Musculoskeletal: Ankle 1': const EpisodeQuiz(
    episodeTitle: 'Musculoskeletal: Ankle 1',
    questions: [
      QuizQuestion(
        question:
            'The most commonly injured ligament in ankle sprains is:',
        options: [
          'Deltoid ligament',
          'Calcaneofibular ligament',
          'Anterior talofibular ligament (ATFL)',
          'Posterior talofibular ligament',
        ],
        correctIndex: 2,
        explanation:
            'The ATFL is the weakest lateral ankle ligament and the most commonly injured in inversion ankle sprains. It is taut in plantarflexion and resists anterior translation of the talus. The injury sequence is ATFL → CFL → PTFL.',
      ),
      QuizQuestion(
        question:
            'The anterior drawer test of the ankle primarily assesses the integrity of which structure?',
        options: [
          'Deltoid ligament',
          'Calcaneofibular ligament',
          'Anterior talofibular ligament',
          'Syndesmosis',
        ],
        correctIndex: 2,
        explanation:
            'The anterior drawer test assesses the ATFL by stabilizing the tibia and pulling the calcaneus/talus anteriorly. Excessive anterior translation compared to the uninjured side indicates ATFL insufficiency.',
      ),
      QuizQuestion(
        question:
            'The Ottawa Ankle Rules state that ankle X-rays are indicated if there is bone tenderness at which of the following locations?',
        options: [
          'Anterior talofibular ligament',
          'Achilles tendon insertion',
          'Posterior edge of the distal 6 cm of the fibula (lateral malleolus)',
          'Anterior tibialis tendon',
        ],
        correctIndex: 2,
        explanation:
            'Ottawa Ankle Rules indicate X-ray if there is: bone tenderness at the posterior edge of the distal 6 cm of the lateral malleolus OR medial malleolus, OR inability to bear weight for 4 steps immediately after injury and in the ED.',
      ),
      QuizQuestion(
        question:
            'A high ankle sprain involves injury to which structure?',
        options: [
          'Anterior talofibular ligament',
          'Deltoid ligament',
          'Tibiofibular syndesmosis',
          'Spring ligament',
        ],
        correctIndex: 2,
        explanation:
            'A high ankle sprain involves the tibiofibular syndesmosis (the interosseous membrane and anterior/posterior tibiofibular ligaments connecting the distal tibia and fibula). It is more serious than a lateral ankle sprain and requires longer recovery. The squeeze test and external rotation test help diagnose it.',
      ),
      QuizQuestion(
        question:
            'The deltoid ligament is located on which side of the ankle and resists which motion?',
        options: [
          'Lateral side; resists inversion',
          'Medial side; resists eversion',
          'Lateral side; resists eversion',
          'Medial side; resists inversion',
        ],
        correctIndex: 1,
        explanation:
            'The deltoid ligament is on the medial side of the ankle and is the strongest ankle ligament. It resists eversion. Deltoid injuries are less common than lateral ligament injuries because the deltoid is so strong — an eversion force is more likely to cause a fracture (especially fibula) than a deltoid tear.',
      ),
    ],
  ),

  // ── MSK Ankle 2 ──
  'Musculoskeletal: Ankle 2': const EpisodeQuiz(
    episodeTitle: 'Musculoskeletal: Ankle 2',
    questions: [
      QuizQuestion(
        question:
            'Achilles tendon rupture classically occurs in which demographic?',
        options: [
          'Adolescent athletes',
          'Middle-aged "weekend warriors"',
          'Elderly sedentary patients',
          'Professional athletes',
        ],
        correctIndex: 1,
        explanation:
            'Achilles ruptures classically occur in middle-aged (30-50) recreational athletes ("weekend warriors") during sudden push-off activities. Risk factors include fluoroquinolone use, corticosteroid injections, and pre-existing tendinopathy.',
      ),
      QuizQuestion(
        question:
            'The Thompson test for Achilles tendon rupture is performed by:',
        options: [
          'Dorsiflexing the ankle against resistance',
          'Squeezing the calf and observing for plantarflexion',
          'Palpating the tendon for a gap',
          'Having the patient walk on toes',
        ],
        correctIndex: 1,
        explanation:
            'The Thompson test: patient prone, squeeze the calf — normal response is passive plantarflexion. If the foot does not plantarflex (positive Thompson), the Achilles tendon is likely ruptured. It is the most reliable clinical test for complete rupture.',
      ),
      QuizQuestion(
        question:
            'Peroneal tendon subluxation most commonly occurs in which direction?',
        options: [
          'Posteriorly behind the lateral malleolus',
          'Anteriorly over the lateral malleolus',
          'Medially under the medial malleolus',
          'Superiorly above the ankle joint',
        ],
        correctIndex: 1,
        explanation:
            'Peroneal tendons sublux anteriorly over the lateral malleolus when the superior peroneal retinaculum is torn. It occurs with forceful dorsiflexion and eversion, commonly in skiing. Patients feel a snapping sensation at the lateral ankle.',
      ),
      QuizQuestion(
        question:
            'Which classification system is used for lateral ankle sprains?',
        options: [
          'Weber classification',
          'Lauge-Hansen classification',
          'Grade I-III severity system',
          'Danis-Weber classification',
        ],
        correctIndex: 2,
        explanation:
            'Lateral ankle sprains use Grade I (stretch/microscopic tear, mild swelling), Grade II (partial tear, moderate swelling, some instability), Grade III (complete tear, significant swelling, gross instability). Weber and Lauge-Hansen classify ankle fractures, not sprains.',
      ),
      QuizQuestion(
        question:
            'Chronic lateral ankle instability most commonly results from repeated injury to which ligament?',
        options: [
          'Deltoid ligament',
          'Spring ligament',
          'Anterior talofibular ligament',
          'Calcaneofibular ligament',
        ],
        correctIndex: 2,
        explanation:
            'Chronic lateral ankle instability most commonly results from repeated ATFL injuries that fail to heal properly. Up to 20% of acute ankle sprains progress to chronic instability. The Broström procedure (direct ligament repair) is the surgical treatment of choice.',
      ),
    ],
  ),

  // ── MSK Elbow 1 ──
  'Musculoskeletal: Elbow 1': const EpisodeQuiz(
    episodeTitle: 'Musculoskeletal: Elbow 1',
    questions: [
      QuizQuestion(
        question:
            'Lateral epicondylitis (tennis elbow) involves which muscle/tendon?',
        options: [
          'Flexor carpi radialis',
          'Extensor carpi radialis brevis',
          'Pronator teres',
          'Biceps brachii',
        ],
        correctIndex: 1,
        explanation:
            'Lateral epicondylitis primarily involves the extensor carpi radialis brevis (ECRB) tendon at the lateral epicondyle. Despite being called "tennis elbow," it is more common in non-tennis activities involving repetitive wrist extension and gripping.',
      ),
      QuizQuestion(
        question:
            'Medial epicondylitis (golfer\'s elbow) involves the origin of which muscle group?',
        options: [
          'Wrist extensors',
          'Wrist flexors and pronators',
          'Supinators',
          'Triceps',
        ],
        correctIndex: 1,
        explanation:
            'Medial epicondylitis affects the common flexor-pronator tendon origin at the medial epicondyle. The flexor carpi radialis and pronator teres are most commonly involved. It is important to assess for ulnar nerve irritation, as the nerve runs in the cubital tunnel just posterior to the medial epicondyle.',
      ),
      QuizQuestion(
        question:
            'The ulnar nerve passes through which anatomic space at the elbow?',
        options: [
          'Radial tunnel',
          'Cubital tunnel',
          'Carpal tunnel',
          'Guyon\'s canal',
        ],
        correctIndex: 1,
        explanation:
            'The ulnar nerve passes through the cubital tunnel (between the medial epicondyle and olecranon). It is the second most common upper extremity nerve entrapment (after carpal tunnel syndrome). Prolonged elbow flexion, direct pressure, and subluxation are risk factors.',
      ),
      QuizQuestion(
        question:
            'The carrying angle of the elbow is normally:',
        options: [
          '0-5 degrees valgus',
          '5-15 degrees valgus',
          '15-25 degrees valgus',
          '25-35 degrees valgus',
        ],
        correctIndex: 1,
        explanation:
            'The normal carrying angle is approximately 5-15 degrees of valgus (larger in women). An increased carrying angle (cubitus valgus) can put the ulnar nerve at risk. A decreased angle (cubitus varus, or "gunstock deformity") can result from a malunited supracondylar fracture.',
      ),
      QuizQuestion(
        question:
            'The primary stabilizer of the elbow against valgus stress is:',
        options: [
          'Lateral collateral ligament',
          'Annular ligament',
          'Ulnar (medial) collateral ligament',
          'Interosseous membrane',
        ],
        correctIndex: 2,
        explanation:
            'The ulnar collateral ligament (UCL/MCL), specifically its anterior band, is the primary stabilizer against valgus stress. UCL injuries are common in overhead throwing athletes. Tommy John surgery involves UCL reconstruction.',
      ),
    ],
  ),

  // ── MSK Elbow 2 ──
  'Musculoskeletal: Elbow 2': const EpisodeQuiz(
    episodeTitle: 'Musculoskeletal: Elbow 2',
    questions: [
      QuizQuestion(
        question:
            'Nursemaid\'s elbow (radial head subluxation) most commonly occurs in which age group?',
        options: [
          'Adolescents',
          'Children under 5 years',
          'Adults over 40',
          'Elderly patients',
        ],
        correctIndex: 1,
        explanation:
            'Nursemaid\'s elbow occurs most commonly in children under 5 years old due to their relatively undeveloped annular ligament. It is caused by a sudden pull on the extended, pronated arm. Reduction involves supination with elbow flexion.',
      ),
      QuizQuestion(
        question:
            'Posterior interosseous nerve (PIN) syndrome at the elbow presents with:',
        options: [
          'Wrist drop with loss of sensation',
          'Finger drop (inability to extend fingers at MCP joints) without sensory loss',
          'Numbness in the thumb and index finger',
          'Weakness of elbow flexion',
        ],
        correctIndex: 1,
        explanation:
            'PIN syndrome causes weakness of finger and thumb extension at the MCP joints without sensory loss (PIN is a motor branch). Wrist extension is partially preserved (ECRL is innervated before the PIN). The Arcade of Frohse is the most common compression site.',
      ),
      QuizQuestion(
        question:
            'Olecranon bursitis is characterized by swelling at which location?',
        options: [
          'Anterior elbow crease',
          'Lateral epicondyle',
          'Posterior tip of the elbow',
          'Medial epicondyle',
        ],
        correctIndex: 2,
        explanation:
            'The olecranon bursa lies superficially over the posterior tip of the olecranon process. Bursitis causes visible swelling at this site ("student\'s elbow" or "miner\'s elbow"). It can be traumatic, infectious (septic), or due to gout/RA. Always aspirate if infection is suspected.',
      ),
      QuizQuestion(
        question:
            'The "terrible triad" of the elbow includes which three injuries?',
        options: [
          'Lateral epicondyle fracture, UCL tear, radial head fracture',
          'Elbow dislocation, radial head fracture, coronoid process fracture',
          'Olecranon fracture, UCL tear, radial nerve injury',
          'Supracondylar fracture, radial head fracture, ulnar nerve injury',
        ],
        correctIndex: 1,
        explanation:
            'The "terrible triad" = posterior elbow dislocation + radial head fracture + coronoid process fracture. It has a high rate of instability and poor outcomes. Surgical fixation of both fractures plus LCL repair is typically required.',
      ),
      QuizQuestion(
        question:
            'Heterotopic ossification (HO) at the elbow is most commonly seen after which type of injury?',
        options: [
          'Lateral epicondylitis',
          'Olecranon bursitis',
          'Elbow dislocation or fracture-dislocation',
          'Cubital tunnel syndrome',
        ],
        correctIndex: 2,
        explanation:
            'HO at the elbow is most common after elbow dislocations and fracture-dislocations, especially with associated head injuries or burns. Prophylaxis with indomethacin or low-dose radiation may be considered in high-risk patients. Surgical excision is delayed until the bone matures.',
      ),
    ],
  ),

  // ── MSK Foot ──
  'Musculoskeletal: Foot': const EpisodeQuiz(
    episodeTitle: 'Musculoskeletal: Foot',
    questions: [
      QuizQuestion(
        question:
            'Morton\'s neuroma most commonly affects which intermetatarsal space?',
        options: [
          'First-second',
          'Second-third',
          'Third-fourth',
          'Fourth-fifth',
        ],
        correctIndex: 2,
        explanation:
            'Morton\'s neuroma most commonly affects the third-fourth intermetatarsal space (between the 3rd and 4th metatarsal heads). It involves the interdigital nerve and presents with burning pain, numbness in adjacent toes, and a positive Mulder\'s click test.',
      ),
      QuizQuestion(
        question:
            'Plantar fasciitis pain is classically described as:',
        options: [
          'Pain at the Achilles insertion that worsens with activity',
          'Heel pain that is worst with the first steps in the morning',
          'Forefoot pain that worsens with toe walking',
          'Lateral ankle pain with weight bearing',
        ],
        correctIndex: 1,
        explanation:
            'Plantar fasciitis presents with medial heel pain at the plantar fascial origin on the calcaneal tubercle. It is classically worst with the first steps in the morning (post-static dyskinesia) and after prolonged sitting, then gradually improves with walking.',
      ),
      QuizQuestion(
        question:
            'A stress fracture of the second metatarsal is also known as a:',
        options: [
          'Jones fracture',
          'March fracture',
          'Lisfranc fracture',
          'Dancer\'s fracture',
        ],
        correctIndex: 1,
        explanation:
            'A "march fracture" is a stress fracture of the second (or third) metatarsal shaft, classically seen in military recruits during basic training. A Jones fracture is at the base of the 5th metatarsal. A dancer\'s fracture is a spiral fracture of the 5th metatarsal shaft.',
      ),
      QuizQuestion(
        question:
            'The Lisfranc joint complex involves the articulation between which structures?',
        options: [
          'Talus and calcaneus',
          'Metatarsal bases and tarsal bones (cuneiforms and cuboid)',
          'Phalanges and metatarsal heads',
          'Navicular and cuneiforms',
        ],
        correctIndex: 1,
        explanation:
            'The Lisfranc joint is the tarsometatarsal joint complex where the metatarsal bases articulate with the cuneiform bones and cuboid. Lisfranc injuries are commonly missed on initial X-rays. The key ligament runs from the medial cuneiform to the base of the second metatarsal.',
      ),
      QuizQuestion(
        question:
            'Hallux rigidus refers to:',
        options: [
          'Lateral deviation of the great toe',
          'Degenerative arthritis of the first MTP joint with limited dorsiflexion',
          'Inflammation of the sesamoid bones',
          'A fracture of the hallux proximal phalanx',
        ],
        correctIndex: 1,
        explanation:
            'Hallux rigidus is osteoarthritis of the first MTP joint characterized by pain and limited dorsiflexion (normally 65-75 degrees). It is the most common arthritic condition of the foot. Hallux valgus (bunion) is lateral deviation of the great toe — a different condition.',
      ),
    ],
  ),
};
