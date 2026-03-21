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

  // ── Electrodiagnostic 3 ──
  'Electrodiagnostic 3': const EpisodeQuiz(
    episodeTitle: 'Electrodiagnostic 3',
    questions: [
      QuizQuestion(
        question: 'In nerve conduction studies, Ohm\'s law (I = V/R) is important because:',
        options: [
          'It determines the speed of nerve conduction',
          'High skin impedance degrades the recorded signal quality',
          'It calculates the distance between electrodes',
          'It measures the safety factor at the NMJ',
        ],
        correctIndex: 1,
        explanation: 'Ohm\'s law explains that high skin resistance (impedance) reduces the recorded signal. Proper skin preparation reduces impedance, improving signal-to-noise ratio. This is why skin abrasion is critical before electrode placement.',
      ),
      QuizQuestion(
        question: 'The ground electrode in nerve conduction studies should be placed:',
        options: [
          'On the contralateral limb',
          'Between the stimulating and recording electrodes',
          'Directly over the motor point',
          'As far from the nerve as possible',
        ],
        correctIndex: 1,
        explanation: 'The ground electrode must be placed between the stimulating and recording electrodes to intercept stimulus artifact. Incorrect placement allows artifact to contaminate the recorded signal.',
      ),
      QuizQuestion(
        question: 'A differential amplifier in the EMG machine works by:',
        options: [
          'Adding G1 and G2 signals together',
          'Subtracting G2 from G1 to cancel common noise',
          'Amplifying only the G1 signal',
          'Filtering out all signals below 100 Hz',
        ],
        correctIndex: 1,
        explanation: 'The differential amplifier subtracts G2 from G1 (G1 - G2), canceling common-mode noise (60 Hz interference, etc.) while preserving the biological signal. The common mode rejection ratio (CMRR) must be >90 dB.',
      ),
      QuizQuestion(
        question: 'The standard low-frequency filter (LFF) and high-frequency filter (HFF) settings for motor NCS are:',
        options: [
          '20 Hz to 2 kHz',
          '2 Hz to 10 kHz',
          '20 Hz to 10 kHz',
          '1 Hz to 5 kHz',
        ],
        correctIndex: 1,
        explanation: 'Motor NCS standard filters: LFF = 2 Hz, HFF = 10 kHz. Sensory NCS uses LFF = 20 Hz, HFF = 10 kHz. Raising the LFF artificially reduces CMAP amplitude; lowering the HFF artificially prolongs latency.',
      ),
      QuizQuestion(
        question: 'Supramaximal stimulation in NCS means stimulating at what intensity above the level that produces maximal response?',
        options: [
          '5% above',
          '10% above',
          '20% above',
          '50% above',
        ],
        correctIndex: 2,
        explanation: 'Supramaximal stimulation is 20% above the intensity that produces the maximal CMAP. This ensures all axons are activated and the response is reproducible. Submaximal stimulation underestimates amplitude.',
      ),
    ],
  ),

  // ── Electrodiagnostic 4 ──
  'Electrodiagnostic 4': const EpisodeQuiz(
    episodeTitle: 'Electrodiagnostic 4',
    questions: [
      QuizQuestion(
        question: 'A patient has clinical sensory loss in a dermatomal distribution but normal SNAPs. The lesion is most likely:',
        options: [
          'Post-ganglionic (distal to DRG)',
          'Pre-ganglionic (proximal to DRG)',
          'At the neuromuscular junction',
          'In the peripheral nerve trunk',
        ],
        correctIndex: 1,
        explanation: 'Pre-ganglionic lesions (radiculopathy) preserve the SNAP because the sensory neuron cell body in the DRG and its peripheral axon remain intact. Post-ganglionic lesions (plexopathy, peripheral neuropathy) damage the axon distal to the DRG, causing abnormal SNAPs.',
      ),
      QuizQuestion(
        question: 'Conduction block on NCS is defined as a drop in CMAP amplitude of greater than what percentage between distal and proximal stimulation sites?',
        options: [
          '25%',
          '40%',
          '50%',
          '75%',
        ],
        correctIndex: 2,
        explanation: 'Conduction block is defined as >50% drop in CMAP amplitude between proximal and distal stimulation sites. It is a hallmark of focal demyelination and indicates that some axons fail to conduct past the lesion site.',
      ),
      QuizQuestion(
        question: 'In the Sunderland classification, which grade involves disruption of the endoneurium with intact perineurium?',
        options: [
          'Grade 1 (neuropraxia)',
          'Grade 2 (axonotmesis)',
          'Grade 3',
          'Grade 4',
        ],
        correctIndex: 2,
        explanation: 'Sunderland Grade 3 involves disruption of the endoneurium with intact perineurium. Grade 1 = neuropraxia (myelin only). Grade 2 = axonotmesis (axon damaged, endoneurium intact). Grade 4 = perineurium damaged. Grade 5 = complete transection (neurotmesis).',
      ),
      QuizQuestion(
        question: 'Temporal dispersion on NCS is caused by:',
        options: [
          'Axonal loss of large fibers',
          'Different conduction velocities of demyelinated fibers',
          'Neuromuscular junction block',
          'Electrode placement errors',
        ],
        correctIndex: 1,
        explanation: 'Temporal dispersion occurs when different fibers conduct at different speeds due to variable degrees of demyelination. Fast and slow fibers arrive at the recording electrode at different times, spreading out and reducing the CMAP amplitude with a widened, polyphasic waveform.',
      ),
      QuizQuestion(
        question: 'The key NCS finding that distinguishes axonal injury from demyelinating injury is:',
        options: [
          'Axonal: slow velocity, normal amplitude',
          'Demyelinating: low amplitude, normal velocity',
          'Axonal: low amplitude, normal velocity',
          'Both show identical findings',
        ],
        correctIndex: 2,
        explanation: 'Axonal injury = reduced amplitude (fewer functioning axons) with normal or near-normal conduction velocity. Demyelinating injury = slow conduction velocity with initially preserved amplitude. This distinction is fundamental to all EDX interpretation.',
      ),
    ],
  ),

  // ── Electrodiagnostic 5 ──
  'Electrodiagnostic 5': const EpisodeQuiz(
    episodeTitle: 'Electrodiagnostic 5',
    questions: [
      QuizQuestion(
        question: 'After a facial nerve injury, prognostic NCS testing should be delayed until at least:',
        options: [
          'Day 1',
          'Day 3',
          'Day 7',
          'Day 14',
        ],
        correctIndex: 2,
        explanation: 'The "seven-day rule": the distal nerve stump remains excitable for 3-7 days after injury due to Wallerian degeneration timeline. Testing before day 7 may show falsely normal responses, giving inaccurate prognosis.',
      ),
      QuizQuestion(
        question: 'A facial nerve CMAP amplitude less than 10% of the normal side indicates:',
        options: [
          'Excellent prognosis, recovery in weeks',
          'Good prognosis, recovery in 2 months',
          'Fair prognosis, recovery in 2-8 months',
          'Poor prognosis, recovery may take over 1 year',
        ],
        correctIndex: 3,
        explanation: 'Facial nerve prognosis by CMAP amplitude: >30% = good (recovery <2 months), 10-30% = fair (2-8 months), <10% = poor (>1 year recovery). This guides counseling and surgical decision-making.',
      ),
      QuizQuestion(
        question: 'The phrenic nerve is stimulated at which anatomical landmark for NCS?',
        options: [
          'Anterior triangle of the neck at the thyroid cartilage',
          'Posterior border of the SCM, 3 cm above the clavicle',
          'Suprasternal notch',
          'Axilla at the level of the second rib',
        ],
        correctIndex: 1,
        explanation: 'The phrenic nerve is stimulated at the posterior border of the sternocleidomastoid (SCM) muscle, approximately 3 cm above the clavicle. Recording is at the xiphoid process with a 16 cm electrode distance.',
      ),
      QuizQuestion(
        question: 'In somatosensory evoked potentials (SSEPs) for the median nerve, the N20 waveform represents arrival at which structure?',
        options: [
          'Brachial plexus',
          'Cervical spinal cord',
          'Thalamus',
          'Primary somatosensory cortex',
        ],
        correctIndex: 3,
        explanation: 'Median nerve SSEP checkpoints: N9 = brachial plexus (Erb\'s point), N11 = root entry zone, N13 = cervical cord/medulla, P14 = brainstem, N18 = thalamus, N20 = primary somatosensory cortex. The number roughly corresponds to milliseconds.',
      ),
      QuizQuestion(
        question: 'During intraoperative SSEP monitoring, which anesthetic agents should be avoided because they suppress cortical signals?',
        options: [
          'Propofol and narcotics',
          'Halogenated anesthetics (sevoflurane, isoflurane)',
          'Ketamine',
          'Dexmedetomidine',
        ],
        correctIndex: 1,
        explanation: 'Halogenated anesthetics (sevoflurane, isoflurane, desflurane) suppress cortical SSEP signals and can mimic CNS injury. Total intravenous anesthesia (TIVA) with propofol and narcotics is preferred for intraoperative neuromonitoring.',
      ),
    ],
  ),

  // ── Electrodiagnostic 6 ──
  'Electrodiagnostic 6': const EpisodeQuiz(
    episodeTitle: 'Electrodiagnostic 6',
    questions: [
      QuizQuestion(
        question: 'Fibrillation potentials on EMG represent the spontaneous firing of:',
        options: [
          'An entire motor unit',
          'A single muscle fiber',
          'A group of motor units',
          'The neuromuscular junction',
        ],
        correctIndex: 1,
        explanation: 'Fibrillations are spontaneous discharges of individual denervated muscle fibers. They are not visible through the skin (unlike fasciculations) and produce a high-pitched ticking sound at 20-200 μV amplitude.',
      ),
      QuizQuestion(
        question: 'How can you distinguish benign fasciculations from pathologic fasciculations on EMG?',
        options: [
          'Benign fasciculations fire at higher rates',
          'Pathologic fasciculations are larger in amplitude',
          'You cannot — clinical context and the company they keep (fibrillations) are key',
          'Benign fasciculations occur only at rest',
        ],
        correctIndex: 2,
        explanation: 'Fasciculations cannot be reliably differentiated as benign vs pathologic by EMG waveform alone. The "company they keep" principle: fasciculations accompanied by fibrillation potentials and other signs of denervation suggest pathology (ALS, radiculopathy).',
      ),
      QuizQuestion(
        question: 'Myokymic discharges on EMG produce a characteristic sound described as:',
        options: [
          'Rain on a tin roof',
          'Dive bombers',
          'Marching soldiers',
          'Machine gun fire',
        ],
        correctIndex: 2,
        explanation: 'Myokymia produces a "marching soldiers" sound — rhythmic grouped bursts of motor unit potentials. It is classically associated with radiation-induced plexopathy and helps distinguish radiation damage from tumor recurrence.',
      ),
      QuizQuestion(
        question: 'A motor unit action potential (MUAP) with more than 4 phases is described as:',
        options: [
          'Simple',
          'Biphasic',
          'Triphasic',
          'Polyphasic',
        ],
        correctIndex: 3,
        explanation: 'Normal MUAPs have 2-4 phases. MUAPs with >4 phases are polyphasic, indicating remodeling of the motor unit — either from reinnervation (neuropathic) or fiber splitting/regeneration (myopathic). Up to 15% polyphasic MUAPs can be normal.',
      ),
      QuizQuestion(
        question: 'MUAP duration on EMG primarily reflects:',
        options: [
          'The number of fibers near the needle tip',
          'The entire territory (spatial extent) of the motor unit',
          'The conduction velocity of the nerve',
          'The thickness of the myelin sheath',
        ],
        correctIndex: 1,
        explanation: 'MUAP duration represents the entire motor unit territory — it reflects the timing of all muscle fibers in that motor unit firing. Duration increases in neuropathic conditions (reinnervation creates larger territories) and decreases in myopathies (lost fibers = smaller territory).',
      ),
    ],
  ),

  // ── Electrodiagnostic 7 ──
  'Electrodiagnostic 7': const EpisodeQuiz(
    episodeTitle: 'Electrodiagnostic 7',
    questions: [
      QuizQuestion(
        question: 'To confirm a radiculopathy on EMG, abnormalities should be found in at least:',
        options: [
          '1 muscle innervated by the suspected root',
          '2 muscles innervated by different peripheral nerves sharing the same root',
          '3 muscles in the same myotome',
          'All muscles innervated by the root',
        ],
        correctIndex: 1,
        explanation: 'The "two-muscle, two-nerve, one-root rule": abnormalities must be found in at least 2 muscles innervated by different peripheral nerves but sharing the same nerve root. This pattern excludes a single peripheral nerve lesion.',
      ),
      QuizQuestion(
        question: 'In radiculopathy, fibrillation potentials first appear in the paraspinal muscles at approximately:',
        options: [
          'Day 1-2',
          'Day 4-5',
          'Week 1 (day 7)',
          'Week 3-4',
        ],
        correctIndex: 2,
        explanation: 'Radiculopathy chronology: Day 0 = decreased recruitment only. Day 4-5 = CMAP amplitude drops. Week 1 = fibrillations in paraspinals first (shortest axons from root). Weeks 2-3 = fibrillations appear in limb muscles. Week 5-6 = early reinnervation potentials.',
      ),
      QuizQuestion(
        question: 'In radiculopathy, SNAPs are characteristically:',
        options: [
          'Absent',
          'Low amplitude',
          'Normal (preserved)',
          'Prolonged in latency',
        ],
        correctIndex: 2,
        explanation: 'SNAPs are NORMAL in radiculopathy because the lesion is pre-ganglionic (proximal to the DRG). The sensory neuron cell body and its peripheral axon remain intact. This is the key finding that distinguishes radiculopathy from plexopathy or peripheral neuropathy.',
      ),
      QuizQuestion(
        question: 'Abnormal paraspinal muscles on EMG help localize the lesion to the:',
        options: [
          'Peripheral nerve',
          'Brachial plexus',
          'Nerve root',
          'Spinal cord',
        ],
        correctIndex: 2,
        explanation: 'Paraspinal muscles are innervated by the posterior rami, which branch off the nerve root before the plexus. Abnormal paraspinals = root-level lesion. Normal paraspinals with limb abnormalities = plexus or peripheral nerve lesion.',
      ),
      QuizQuestion(
        question: 'The C5 nerve root innervates which key muscles?',
        options: [
          'Wrist extensors and triceps',
          'Deltoid and biceps (shoulder abduction and elbow flexion)',
          'Hand intrinsics and finger flexors',
          'Forearm pronators and wrist flexors',
        ],
        correctIndex: 1,
        explanation: 'C5 myotome: deltoid (shoulder abduction) and biceps (elbow flexion). C6 = wrist extension, brachioradialis. C7 = triceps, wrist flexion. C8 = finger flexors. T1 = hand intrinsics. Knowing myotomes is essential for localizing radiculopathies.',
      ),
    ],
  ),

  // ── Electrodiagnostic 8 ──
  'Electrodiagnostic 8': const EpisodeQuiz(
    episodeTitle: 'Electrodiagnostic 8',
    questions: [
      QuizQuestion(
        question: 'Anterior interosseous nerve (AIN) syndrome is characterized by:',
        options: [
          'Sensory loss in the thumb and index finger',
          'Pure motor deficit with inability to form an "OK" sign',
          'Wrist drop with radial deviation',
          'Thenar atrophy and thumb opposition weakness',
        ],
        correctIndex: 1,
        explanation: 'AIN syndrome is pure motor — NO sensory findings. It causes weakness of FPL (thumb IP flexion), FDP to digits 2-3 (index/middle DIP flexion), and pronator quadratus. The positive "OK sign" test (can\'t make a circle) is characteristic. Routine median NCS are NORMAL.',
      ),
      QuizQuestion(
        question: 'In carpal tunnel syndrome, sensation at the base of the thumb is typically:',
        options: [
          'Absent',
          'Decreased',
          'Normal (preserved)',
          'Hyperesthetic',
        ],
        correctIndex: 2,
        explanation: 'The palmar cutaneous branch of the median nerve exits 5 cm proximal to the wrist and travels OVER the transverse carpal ligament, not through the tunnel. Therefore, thenar eminence/thumb base sensation is preserved in CTS. If numb, suspect a more proximal lesion.',
      ),
      QuizQuestion(
        question: 'The carpal tunnel contains how many tendons plus the median nerve?',
        options: [
          '5 tendons + median nerve',
          '7 tendons + median nerve',
          '9 tendons + median nerve',
          '11 tendons + median nerve',
        ],
        correctIndex: 2,
        explanation: 'The "Nine Plus One Rule": 4 FDS tendons + 4 FDP tendons + 1 FPL tendon + 1 median nerve = 10 structures. The FCR tendon runs in its own separate compartment, which is why wrist flexion is preserved in carpal tunnel syndrome.',
      ),
      QuizQuestion(
        question: 'Martin-Gruber anastomosis is a crossover between which two nerves in the forearm?',
        options: [
          'Radial to ulnar',
          'Median to ulnar',
          'Ulnar to median',
          'Musculocutaneous to median',
        ],
        correctIndex: 1,
        explanation: 'Martin-Gruber anastomosis (15-20% prevalence) is a median-to-ulnar nerve crossover in the forearm. Motor fibers from the median nerve cross to join the ulnar nerve. This can cause confusing NCS results in carpal tunnel or ulnar neuropathy.',
      ),
      QuizQuestion(
        question: 'Severe carpal tunnel syndrome on NCS is characterized by:',
        options: [
          'Prolonged sensory latency with normal amplitude',
          'Normal sensory and motor studies',
          'Absent SNAP, prolonged/low motor response, fibrillations in APB',
          'Prolonged sensory latency only',
        ],
        correctIndex: 2,
        explanation: 'CTS severity grading: Mild = prolonged sensory latency only. Moderate = abnormal sensory + prolonged motor latency. Severe = absent SNAP, low/prolonged motor response, and fibrillation potentials in the abductor pollicis brevis (APB) on EMG.',
      ),
    ],
  ),

  // ── Electrodiagnostic 9 ──
  'Electrodiagnostic 9': const EpisodeQuiz(
    episodeTitle: 'Electrodiagnostic 9',
    questions: [
      QuizQuestion(
        question: 'The dorsal ulnar cutaneous (DUC) nerve branches from the ulnar nerve at what location?',
        options: [
          'At Guyon\'s canal',
          '5-8 cm proximal to the wrist',
          'At the cubital tunnel',
          'At the axilla',
        ],
        correctIndex: 1,
        explanation: 'The DUC branches 5-8 cm proximal to the wrist and does NOT travel through Guyon\'s canal. This is a critical landmark: DUC abnormal = lesion at or above the elbow. DUC normal = lesion at wrist (Guyon\'s canal).',
      ),
      QuizQuestion(
        question: 'Froment\'s sign tests for weakness of which muscle?',
        options: [
          'First dorsal interosseous',
          'Adductor pollicis',
          'Opponens pollicis',
          'Flexor pollicis longus',
        ],
        correctIndex: 1,
        explanation: 'Froment\'s sign: patient tries to hold paper between thumb and index finger. The adductor pollicis (ulnar nerve) is weak, so the patient compensates by flexing the thumb IP joint using FPL (median nerve). IP flexion during pinch = positive Froment sign = ulnar neuropathy.',
      ),
      QuizQuestion(
        question: 'How do you differentiate radiation-induced brachial plexopathy from tumor recurrence on EMG?',
        options: [
          'Radiation causes fasciculations; tumor causes fibrillations',
          'Radiation shows myokymic discharges; tumor is typically painful with Horner syndrome',
          'They cannot be differentiated on EMG',
          'Radiation affects lower trunk; tumor affects upper trunk',
        ],
        correctIndex: 1,
        explanation: 'Key differentiators: Radiation plexopathy = painless, upper trunk predominant, myokymic discharges (marching soldiers on EMG). Tumor recurrence = painful, lower trunk predominant, may have Horner syndrome (ptosis, miosis, anhydrosis). Myokymia is the EMG key.',
      ),
      QuizQuestion(
        question: 'Ulnar claw hand affects primarily which digits?',
        options: [
          'Thumb and index finger',
          'Index and middle fingers',
          'Ring and little fingers',
          'All five digits equally',
        ],
        correctIndex: 2,
        explanation: 'Ulnar claw hand primarily affects the 4th and 5th digits. The unopposed EDC hyperextends the MCPs, and passive tension on the flexor tendons curls the PIP/DIP joints. The index and middle fingers are relatively spared because their lumbricals are median-innervated.',
      ),
      QuizQuestion(
        question: 'Wartenberg\'s sign is demonstrated by:',
        options: [
          'Inability to cross the fingers',
          'The small finger drifting into abduction at rest due to weak interossei',
          'Weakness of thumb opposition',
          'Inability to extend the wrist',
        ],
        correctIndex: 1,
        explanation: 'Wartenberg\'s sign: the small finger drifts into abduction because the third palmar interosseous (ulnar nerve) is weak and cannot adduct the 5th digit against the unopposed action of EDM. It is a subtle early sign of ulnar neuropathy.',
      ),
    ],
  ),

  // ── Electrodiagnostic 10 ──
  'Electrodiagnostic 10': const EpisodeQuiz(
    episodeTitle: 'Electrodiagnostic 10',
    questions: [
      QuizQuestion(
        question: 'The "short head of biceps femoris" rule helps distinguish between:',
        options: [
          'L4 vs L5 radiculopathy',
          'Common peroneal neuropathy at the fibular head vs sciatic neuropathy',
          'Tibial vs peroneal nerve injury',
          'Femoral vs obturator neuropathy',
        ],
        correctIndex: 1,
        explanation: 'The short head of biceps femoris is the only peroneal division muscle above the fibular head. If normal on EMG = lesion at the knee (peroneal neuropathy). If abnormal = lesion above the knee (sciatic neuropathy). This is a critical EMG landmark.',
      ),
      QuizQuestion(
        question: 'In tarsal tunnel syndrome, heel sensation is typically:',
        options: [
          'Absent',
          'Decreased',
          'Preserved (normal)',
          'Hyperesthetic',
        ],
        correctIndex: 2,
        explanation: 'Heel sensation is preserved in tarsal tunnel syndrome because the calcaneal branch exits proximal to the tarsal tunnel. If the heel is numb, consider S1 radiculopathy or a more proximal tibial nerve lesion instead.',
      ),
      QuizQuestion(
        question: 'Meralgia paresthetica involves which nerve?',
        options: [
          'Femoral nerve',
          'Obturator nerve',
          'Lateral femoral cutaneous nerve',
          'Saphenous nerve',
        ],
        correctIndex: 2,
        explanation: 'Meralgia paresthetica is entrapment of the lateral femoral cutaneous nerve (LFCN) under the inguinal ligament. It is purely sensory — causing numbness/burning on the anterolateral thigh. There is NEVER motor weakness. Common in obesity, pregnancy, tight waistbands.',
      ),
      QuizQuestion(
        question: 'To distinguish femoral neuropathy from an L3/L4 radiculopathy, you should test:',
        options: [
          'Ankle dorsiflexion',
          'Hip abduction',
          'Hip adduction (obturator nerve)',
          'Knee extension only',
        ],
        correctIndex: 2,
        explanation: 'Hip adduction is innervated by the obturator nerve (L2-L4). Weak quadriceps + weak adductors = root-level lesion (L3/L4). Weak quadriceps + strong adductors = femoral neuropathy (obturator nerve spared). The adductors are the differentiator.',
      ),
      QuizQuestion(
        question: 'The sciatic nerve is more prone to peroneal division injury because:',
        options: [
          'The peroneal division carries more fibers',
          'The peroneal division is tethered at two points and has fewer fascicles with less connective tissue',
          'The tibial division is superficial and more exposed',
          'The peroneal division lacks a blood supply',
        ],
        correctIndex: 1,
        explanation: 'The peroneal division is tethered at the sciatic notch AND the fibular head (two fixed points). It has fewer fascicles and less surrounding connective tissue than the tibial division. This makes it more vulnerable to stretch and compression injuries.',
      ),
    ],
  ),

  // ── Electrodiagnostic 11 ──
  'Electrodiagnostic 11': const EpisodeQuiz(
    episodeTitle: 'Electrodiagnostic 11',
    questions: [
      QuizQuestion(
        question: 'Common peroneal neuropathy at the fibular head is the most common entrapment neuropathy in which region?',
        options: [
          'Upper extremity',
          'Lower extremity',
          'Trunk',
          'Neck',
        ],
        correctIndex: 1,
        explanation: 'Common peroneal neuropathy at the fibular head is the most common lower extremity entrapment neuropathy. It causes foot drop with a steppage gait pattern. Risk factors include leg crossing, prolonged bed rest, weight loss, and fibular head fractures.',
      ),
      QuizQuestion(
        question: 'Diabetic amyotrophy (diabetic lumbosacral radiculoplexus neuropathy) is caused by:',
        options: [
          'Metabolic damage from chronic hyperglycemia',
          'Immune-mediated vasculitis of the vasa nervorum',
          'Direct glucose toxicity to motor neurons',
          'Compression from diabetic lipohypertrophy',
        ],
        correctIndex: 1,
        explanation: 'Diabetic amyotrophy (DLRPN) is NOT metabolic — it is immune-mediated vasculitis of the vasa nervorum. It causes severe pain followed by proximal weakness, often after weight loss or improved glycemic control. It is multifocal, asymmetric, and can be bilateral.',
      ),
      QuizQuestion(
        question: 'A mononeuritis multiplex pattern on NCS (multifocal, asymmetric, patchy nerve involvement) is most suggestive of:',
        options: [
          'Diabetic peripheral neuropathy',
          'Carpal tunnel syndrome',
          'Vasculitis',
          'Hereditary neuropathy',
        ],
        correctIndex: 2,
        explanation: 'Mononeuritis multiplex (multifocal, asymmetric, patchy nerve involvement) is the hallmark pattern of vasculitis affecting the vasa nervorum. Each nerve is hit randomly as its individual blood supply is attacked. This pattern demands workup for systemic vasculitis.',
      ),
      QuizQuestion(
        question: 'Foot drop with a steppage gait is characterized by:',
        options: [
          'Circumducting the leg in an arc',
          'Dropping the opposite hip during stance',
          'Exaggerated knee flexion to clear the dropping foot',
          'Waddling side to side',
        ],
        correctIndex: 2,
        explanation: 'Steppage gait: the patient lifts the knee higher than normal during swing phase to clear the dropping foot from the ground. It results from ankle dorsiflexor weakness (peroneal nerve or L5 root). Circumduction = UMN/hip weakness. Trendelenburg = gluteus medius weakness.',
      ),
      QuizQuestion(
        question: 'The sural nerve is most useful in NCS because:',
        options: [
          'It is the largest sensory nerve in the body',
          'It is easily accessible and provides a reliable lower extremity SNAP',
          'It is purely motor',
          'It innervates the entire foot',
        ],
        correctIndex: 1,
        explanation: 'The sural nerve (terminal sensory branch of the tibial nerve) is easily accessible at the mid-calf behind the lateral malleolus. It provides a reliable lower extremity SNAP and is routinely tested in neuropathy evaluations. Its absence strongly suggests a generalized neuropathy.',
      ),
    ],
  ),

  // ── Electrodiagnostic 12 ──
  'Electrodiagnostic 12': const EpisodeQuiz(
    episodeTitle: 'Electrodiagnostic 12',
    questions: [
      QuizQuestion(
        question: 'The key NCS distinction between hereditary and acquired demyelinating neuropathies is:',
        options: [
          'Hereditary shows conduction block; acquired shows uniform slowing',
          'Hereditary shows uniform slowing; acquired shows conduction block and temporal dispersion',
          'There is no electrodiagnostic difference',
          'Hereditary affects sensory nerves only',
        ],
        correctIndex: 1,
        explanation: 'Hereditary demyelinating neuropathies (CMT1) show uniform slowing across all nerves without conduction block or temporal dispersion. Acquired demyelinating neuropathies (GBS, CIDP) show patchy, non-uniform slowing WITH conduction block and temporal dispersion.',
      ),
      QuizQuestion(
        question: 'Charcot-Marie-Tooth Type 1 is caused by duplication of which gene on chromosome 17?',
        options: [
          'SOD1',
          'Dystrophin',
          'PMP-22',
          'SMN1',
        ],
        correctIndex: 2,
        explanation: 'CMT1 (the most common hereditary neuropathy) is caused by PMP-22 gene duplication on chromosome 17. This produces too much peripheral myelin protein, leading to abnormal myelination. Conduction velocities are severely and uniformly slowed (<38 m/s).',
      ),
      QuizQuestion(
        question: 'Hereditary Neuropathy with Liability to Pressure Palsies (HNPP) is caused by:',
        options: [
          'PMP-22 duplication',
          'PMP-22 deletion',
          'SOD1 mutation',
          'SMN1 deletion',
        ],
        correctIndex: 1,
        explanation: 'HNPP is caused by PMP-22 deletion — the reciprocal of CMT1 (which is PMP-22 duplication). HNPP patients develop prolonged nerve palsies (weeks-long foot drop or wrist drop) from minor compression that would not affect normal individuals.',
      ),
      QuizQuestion(
        question: 'Guillain-Barré syndrome (GBS) is characterized by which CSF finding?',
        options: [
          'Low protein, high white cells',
          'High protein, normal cell count (albuminocytologic dissociation)',
          'Normal protein, high white cells',
          'Low protein, low glucose',
        ],
        correctIndex: 1,
        explanation: 'GBS shows albuminocytologic dissociation: elevated CSF protein with normal cell count. This classic CSF pattern, combined with ascending weakness and areflexia, is highly suggestive of GBS. Treatment is IVIG or plasmapheresis — NOT steroids.',
      ),
      QuizQuestion(
        question: 'The distinction between GBS and CIDP is primarily based on:',
        options: [
          'EMG findings',
          'CSF protein levels',
          'Time course — GBS peaks by 4 weeks; CIDP continues beyond 8 weeks',
          'Presence of conduction block',
        ],
        correctIndex: 2,
        explanation: 'GBS is acute — it reaches nadir within 4 weeks. CIDP (Chronic Inflammatory Demyelinating Polyneuropathy) progresses beyond 8 weeks and has a relapsing-remitting or chronic progressive course. Unlike GBS, CIDP responds to steroids.',
      ),
    ],
  ),

  // ── Electrodiagnostic 13 ──
  'Electrodiagnostic 13': const EpisodeQuiz(
    episodeTitle: 'Electrodiagnostic 13',
    questions: [
      QuizQuestion(
        question: 'In myasthenia gravis (MG), the neuromuscular junction defect is:',
        options: [
          'Presynaptic — reduced ACh release',
          'Postsynaptic — antibodies against ACh receptors',
          'Presynaptic — blocked calcium channels',
          'Synaptic — excess acetylcholinesterase',
        ],
        correctIndex: 1,
        explanation: 'MG is a postsynaptic disorder — autoantibodies attack ACh receptors, reducing the number of available receptors and simplifying the postsynaptic membrane. Quantum content (release) is normal, but quantum response is reduced.',
      ),
      QuizQuestion(
        question: 'Lambert-Eaton myasthenic syndrome (LEMS) differs from MG in that LEMS shows:',
        options: [
          'Weakness that worsens with use and preserved reflexes',
          'Weakness that improves with exercise and depressed reflexes',
          'Pure sensory symptoms',
          'Normal NMJ function on repetitive nerve stimulation',
        ],
        correctIndex: 1,
        explanation: 'LEMS: weakness IMPROVES with exercise (warm-up phenomenon), reflexes are depressed/absent. MG: weakness WORSENS with use, reflexes preserved. LEMS is presynaptic (anti-VGCC antibodies) and associated with small cell lung cancer in ~60% of cases.',
      ),
      QuizQuestion(
        question: 'On repetitive nerve stimulation (RNS), LEMS shows which pattern?',
        options: [
          'Decrement at low rate only',
          'Decrement at low rate with INCREMENT at high rate (post-tetanic potentiation)',
          'No change at any rate',
          'Increment at all rates',
        ],
        correctIndex: 1,
        explanation: 'LEMS shows decrement at low-rate stimulation (2-5 Hz) — like MG — but characteristically shows a dramatic INCREMENT (>100% increase) at high-rate stimulation (20-50 Hz) or after brief maximal voluntary contraction. This post-tetanic potentiation is diagnostic for LEMS.',
      ),
      QuizQuestion(
        question: 'Single-fiber EMG (SFEMG) is the most sensitive test for NMJ disorders because it measures:',
        options: [
          'Conduction velocity between nodes',
          'Jitter — the variability in transmission time between nerve and muscle',
          'CMAP amplitude decline',
          'F-wave latency',
        ],
        correctIndex: 1,
        explanation: 'SFEMG measures jitter — the variability in neuromuscular transmission time between successive firings. Increased jitter and blocking (intermittent transmission failure) are the earliest and most sensitive findings in NMJ disorders like MG.',
      ),
      QuizQuestion(
        question: 'Botulism toxin causes NMJ dysfunction by blocking:',
        options: [
          'ACh receptor binding',
          'Acetylcholinesterase activity',
          'SNARE proteins (preventing vesicle exocytosis)',
          'Voltage-gated calcium channels',
        ],
        correctIndex: 2,
        explanation: 'Botulinum toxin blocks SNARE proteins, the molecular machinery required for synaptic vesicle fusion and ACh release (exocytosis). It is a presynaptic disorder like LEMS, but the mechanism is different — toxin destruction vs autoimmune blockade.',
      ),
    ],
  ),

  // ── Electrodiagnostic 14 ──
  'Electrodiagnostic 14': const EpisodeQuiz(
    episodeTitle: 'Electrodiagnostic 14',
    questions: [
      QuizQuestion(
        question: 'The "reading frame hypothesis" explains the difference between Duchenne and Becker muscular dystrophy as:',
        options: [
          'Different genes are affected',
          'Duchenne has an out-of-frame deletion (no dystrophin); Becker has an in-frame deletion (some dystrophin)',
          'Duchenne is autosomal dominant; Becker is autosomal recessive',
          'Duchenne affects Type I fibers; Becker affects Type II fibers',
        ],
        correctIndex: 1,
        explanation: 'Both affect the dystrophin gene on the X chromosome. Duchenne = out-of-frame deletion producing no functional dystrophin (severe, wheelchair by 12, death by 20s). Becker = in-frame deletion producing shortened but partially functional dystrophin (milder, later onset).',
      ),
      QuizQuestion(
        question: 'The classic EMG triad of myopathy includes all EXCEPT:',
        options: [
          'Low amplitude MUAPs',
          'Short duration MUAPs',
          'Polyphasic MUAPs',
          'Decreased recruitment (reduced interference pattern)',
        ],
        correctIndex: 3,
        explanation: 'Myopathic EMG triad: low amplitude, short duration, polyphasic MUAPs (sounds like rain on a tin roof). Crucially, recruitment is EARLY — the brain compensates for weak motor units by recruiting more units sooner. Decreased recruitment is a NEUROPATHIC pattern.',
      ),
      QuizQuestion(
        question: 'Gower\'s sign (walking hands up the thighs to stand) is pathognomonic for:',
        options: [
          'Myasthenia gravis',
          'Duchenne muscular dystrophy',
          'ALS',
          'Guillain-Barré syndrome',
        ],
        correctIndex: 1,
        explanation: 'Gower\'s sign is pathognomonic for Duchenne MD. The child uses their arms to "climb up" their own legs because proximal hip and thigh muscles are too weak to stand independently. Also characteristic: pseudohypertrophy of calves (fat/fibrosis replacement).',
      ),
      QuizQuestion(
        question: 'Myotonic dystrophy (Steinert disease) is unique among myopathies because it causes:',
        options: [
          'Proximal weakness only',
          'Distal weakness with multisystem involvement',
          'Pure motor neuron degeneration',
          'Immune-mediated muscle inflammation',
        ],
        correctIndex: 1,
        explanation: 'Myotonic dystrophy is distinctive for causing DISTAL weakness (opposite of most myopathies), plus multisystem effects: hatchet face, frontal balding, ptosis, cataracts, cardiac conduction defects, diabetes, testicular atrophy. EMG shows dive-bomber myotonic discharges.',
      ),
      QuizQuestion(
        question: 'The characteristic EMG sound in myotonic dystrophy is described as:',
        options: [
          'Marching soldiers',
          'Rain on a tin roof',
          'Dive bombers',
          'Machine gun fire',
        ],
        correctIndex: 2,
        explanation: 'Myotonic discharges produce a "dive bomber" sound — a waxing and waning frequency and amplitude pattern. Myotonia is worsened by cold and improved by warm-up (repeated muscle activation). This auditory pattern is one of the most recognizable EMG findings.',
      ),
    ],
  ),

  // ── Electrodiagnostic 15 ──
  'Electrodiagnostic 15': const EpisodeQuiz(
    episodeTitle: 'Electrodiagnostic 15',
    questions: [
      QuizQuestion(
        question: 'ALS is characterized by the combination of:',
        options: [
          'Upper motor neuron signs only',
          'Lower motor neuron signs only',
          'Both upper and lower motor neuron signs in the same patient',
          'Sensory and motor deficits',
        ],
        correctIndex: 2,
        explanation: 'ALS uniquely combines UMN signs (spasticity, hyperreflexia, Babinski) AND LMN signs (atrophy, fasciculations, fibrillations) in the same patient, often in the same limb. This combination is the hallmark that distinguishes ALS from pure UMN or LMN diseases.',
      ),
      QuizQuestion(
        question: 'Which three systems are characteristically SPARED in ALS?',
        options: [
          'Motor, sensory, and autonomic',
          'Sensation, bowel/bladder, and eye movements',
          'Cognition, respiration, and swallowing',
          'Reflexes, coordination, and balance',
        ],
        correctIndex: 1,
        explanation: 'The ALS sparing triad: (1) Sensation — SNAPs are normal, (2) Bowel/bladder — sphincters spared until very late, (3) Eye movements — extraocular muscles spared until end-stage. If any of these are prominently affected early, reconsider the diagnosis.',
      ),
      QuizQuestion(
        question: 'To diagnose ALS using the El Escorial criteria, EMG must show active denervation and chronic reinnervation in at least how many body regions?',
        options: [
          '1 of 4 regions',
          '2 of 4 regions',
          '3 of 4 regions',
          'All 4 regions',
        ],
        correctIndex: 2,
        explanation: 'El Escorial criteria require findings in 3 of 4 body segments: (1) bulbar/cranial, (2) cervical, (3) thoracic, (4) lumbosacral. Each region must show both active denervation (fibrillations/PSWs) and chronic reinnervation (large polyphasic MUAPs).',
      ),
      QuizQuestion(
        question: 'Multifocal motor neuropathy (MMN) is an important ALS mimic because it is:',
        options: [
          'Always fatal',
          'Treatable with IVIG and shows conduction block on NCS',
          'Identical to ALS on EMG',
          'Associated with sensory loss',
        ],
        correctIndex: 1,
        explanation: 'MMN is treatable with IVIG — making it critical to distinguish from ALS. Key features: conduction block on NCS (ALS has NO conduction block), anti-GM1 antibodies, and pure motor involvement. Unlike ALS, MMN has a normal life expectancy with treatment.',
      ),
      QuizQuestion(
        question: 'Spinal Muscular Atrophy Type I (Werdnig-Hoffmann) presents at what age?',
        options: [
          'Birth to 6 months',
          '6-18 months',
          'After 18 months',
          'Adolescence',
        ],
        correctIndex: 0,
        explanation: 'SMA Type I (Werdnig-Hoffmann): onset before 6 months, floppy baby, never achieves sitting, most severe. Type II: 6-18 months, can sit but never walks. Type III (Kugelberg-Welander): after 18 months, walks then loses function. All are autosomal recessive (SMN1 gene).',
      ),
    ],
  ),

  // ── Musculoskeletal: Shoulder 1 ──
  'Musculoskeletal: Shoulder 1': const EpisodeQuiz(
    episodeTitle: 'Musculoskeletal: Shoulder 1',
    questions: [
      QuizQuestion(
        question: 'The rotator cuff is composed of four muscles. Which muscle is NOT part of the rotator cuff?',
        options: ['Supraspinatus', 'Infraspinatus', 'Deltoid', 'Teres minor'],
        correctIndex: 2,
        explanation: 'The rotator cuff consists of the SITS muscles: Supraspinatus, Infraspinatus, Teres minor, and Subscapularis. The deltoid is the primary shoulder abductor but is not part of the rotator cuff.',
      ),
      QuizQuestion(
        question: 'Which rotator cuff muscle is most commonly torn?',
        options: ['Subscapularis', 'Infraspinatus', 'Supraspinatus', 'Teres minor'],
        correctIndex: 2,
        explanation: 'The supraspinatus is most commonly torn due to its location in the subacromial space and its relatively poor blood supply in the "critical zone" near its insertion on the greater tuberosity.',
      ),
      QuizQuestion(
        question: 'The "empty can" test primarily evaluates which muscle?',
        options: ['Infraspinatus', 'Subscapularis', 'Supraspinatus', 'Teres minor'],
        correctIndex: 2,
        explanation: 'The empty can (Jobe) test: arm at 90° abduction, 30° forward flexion, internally rotated (thumb down). Resist downward pressure. Weakness or pain = supraspinatus pathology.',
      ),
      QuizQuestion(
        question: 'The glenohumeral joint has the greatest range of motion of any joint in the body. What is the primary trade-off?',
        options: ['Reduced blood supply', 'Inherent instability', 'Limited nerve innervation', 'Decreased muscle attachment points'],
        correctIndex: 1,
        explanation: 'The glenohumeral joint sacrifices stability for mobility. The glenoid fossa is shallow (covers only ~25% of the humeral head), making it the most commonly dislocated joint. Stability relies on the labrum, capsule, rotator cuff, and ligaments.',
      ),
      QuizQuestion(
        question: 'Anterior shoulder dislocations most commonly injure which nerve?',
        options: ['Suprascapular nerve', 'Long thoracic nerve', 'Axillary nerve', 'Musculocutaneous nerve'],
        correctIndex: 2,
        explanation: 'The axillary nerve wraps around the surgical neck of the humerus and is most vulnerable during anterior dislocations. Test for deltoid weakness and decreased sensation over the lateral "regimental badge" area. Incidence increases with age.',
      ),
    ],
  ),

  // ── Musculoskeletal: Shoulder 2 ──
  'Musculoskeletal: Shoulder 2': const EpisodeQuiz(
    episodeTitle: 'Musculoskeletal: Shoulder 2',
    questions: [
      QuizQuestion(
        question: 'Neer\'s impingement test involves:',
        options: ['Resisted external rotation at 0° abduction', 'Passive forward flexion with the scapula stabilized', 'Resisted abduction in the empty can position', 'Cross-body adduction'],
        correctIndex: 1,
        explanation: 'Neer\'s test: the examiner stabilizes the scapula and passively forward flexes the arm overhead. Pain indicates impingement of the supraspinatus tendon against the anterior acromion.',
      ),
      QuizQuestion(
        question: 'Type III acromion morphology is associated with increased risk of rotator cuff impingement because it is:',
        options: ['Flat', 'Curved', 'Hooked', 'Absent'],
        correctIndex: 2,
        explanation: 'Bigliani classification: Type I = flat, Type II = curved, Type III = hooked. The hooked (Type III) acromion narrows the subacromial space, increasing mechanical impingement of the supraspinatus tendon.',
      ),
      QuizQuestion(
        question: 'The Hawkins-Kennedy test for shoulder impingement is performed by:',
        options: ['Resisted external rotation at the side', 'Forward flexing the arm to 90° then internally rotating', 'Resisted abduction in the scapular plane', 'Cross-body adduction with the arm at 90°'],
        correctIndex: 1,
        explanation: 'Hawkins-Kennedy: flex the arm to 90° then forcefully internally rotate. This drives the supraspinatus tendon against the coracoacromial ligament. Pain = positive for impingement.',
      ),
      QuizQuestion(
        question: 'Scapular winging is most commonly caused by injury to which nerve?',
        options: ['Axillary nerve', 'Suprascapular nerve', 'Long thoracic nerve', 'Dorsal scapular nerve'],
        correctIndex: 2,
        explanation: 'The long thoracic nerve innervates the serratus anterior, which holds the scapula against the chest wall. Injury causes medial winging — the scapula protrudes posteriorly, especially when pushing against a wall.',
      ),
      QuizQuestion(
        question: 'Adhesive capsulitis (frozen shoulder) is characterized by loss of both active AND passive ROM. Which motion is typically lost first?',
        options: ['Flexion', 'Abduction', 'External rotation', 'Internal rotation'],
        correctIndex: 2,
        explanation: 'External rotation is typically lost first and most severely in adhesive capsulitis because the inferior glenohumeral ligament (tightest in external rotation) is the first capsular structure to contract. The capsular pattern is external rotation > abduction > internal rotation.',
      ),
    ],
  ),

  // ── Musculoskeletal: Shoulder 3 ──
  'Musculoskeletal: Shoulder 3': const EpisodeQuiz(
    episodeTitle: 'Musculoskeletal: Shoulder 3',
    questions: [
      QuizQuestion(
        question: 'A SLAP lesion involves a tear of the:',
        options: ['Rotator cuff insertion', 'Superior labrum from anterior to posterior', 'Inferior glenohumeral ligament', 'Coracoacromial ligament'],
        correctIndex: 1,
        explanation: 'SLAP = Superior Labrum Anterior to Posterior. It involves the superior labrum at the biceps anchor. Common in overhead athletes and after falls on an outstretched hand. O\'Brien\'s test is used for diagnosis.',
      ),
      QuizQuestion(
        question: 'The Speed\'s test evaluates pathology of which structure?',
        options: ['Supraspinatus tendon', 'Biceps tendon (long head)', 'Subscapularis tendon', 'Acromioclavicular joint'],
        correctIndex: 1,
        explanation: 'Speed\'s test: resist forward flexion with the elbow extended and forearm supinated. Pain at the anterior shoulder/bicipital groove = biceps tendinopathy or SLAP lesion.',
      ),
      QuizQuestion(
        question: 'AC joint pathology is best assessed with which provocative test?',
        options: ['Neer\'s test', 'Cross-body adduction test', 'Empty can test', 'Apprehension test'],
        correctIndex: 1,
        explanation: 'The cross-body adduction (scarf) test: adduct the arm across the chest. Pain at the AC joint = positive for AC joint pathology (arthritis, separation, or distal clavicle osteolysis).',
      ),
      QuizQuestion(
        question: 'The apprehension test is positive for:',
        options: ['Rotator cuff tear', 'AC joint arthritis', 'Anterior glenohumeral instability', 'Biceps tendinopathy'],
        correctIndex: 2,
        explanation: 'The apprehension test: arm at 90° abduction and external rotation. The patient feels a sense of impending dislocation (apprehension, not just pain) = positive for anterior glenohumeral instability. The relocation test (posterior pressure on humeral head) should relieve the apprehension.',
      ),
      QuizQuestion(
        question: 'Suprascapular neuropathy causes weakness of which two muscles?',
        options: ['Deltoid and teres minor', 'Supraspinatus and infraspinatus', 'Subscapularis and teres major', 'Biceps and brachialis'],
        correctIndex: 1,
        explanation: 'The suprascapular nerve innervates the supraspinatus (abduction initiation) and infraspinatus (external rotation). Entrapment at the suprascapular notch affects both; entrapment at the spinoglenoid notch affects only infraspinatus.',
      ),
    ],
  ),

  // ── Musculoskeletal: Shoulder 4 ──
  'Musculoskeletal: Shoulder 4': const EpisodeQuiz(
    episodeTitle: 'Musculoskeletal: Shoulder 4',
    questions: [
      QuizQuestion(
        question: 'The lift-off test (Gerber test) evaluates which rotator cuff muscle?',
        options: ['Supraspinatus', 'Infraspinatus', 'Subscapularis', 'Teres minor'],
        correctIndex: 2,
        explanation: 'The lift-off test: hand placed behind the back (internally rotated), patient pushes away from the back. Inability to lift the hand off = subscapularis tear. The belly press test is an alternative for patients who cannot reach behind their back.',
      ),
      QuizQuestion(
        question: 'Calcific tendinitis most commonly affects which rotator cuff tendon?',
        options: ['Infraspinatus', 'Subscapularis', 'Teres minor', 'Supraspinatus'],
        correctIndex: 3,
        explanation: 'Calcific tendinitis most commonly affects the supraspinatus tendon in its critical zone of relative hypovascularity. The resorptive phase is the most painful. Treatment ranges from NSAIDs and PT to needle aspiration or ultrasound-guided barbotage.',
      ),
      QuizQuestion(
        question: 'Thoracic outlet syndrome (TOS) with lower trunk involvement (C8-T1) presents with:',
        options: ['Deltoid weakness and lateral arm numbness', 'Hand intrinsic weakness and medial forearm/hand numbness', 'Shoulder pain with overhead activities', 'Biceps weakness and lateral forearm numbness'],
        correctIndex: 1,
        explanation: 'Neurogenic TOS affecting the lower trunk (C8-T1) presents with hand intrinsic muscle weakness/atrophy and numbness in the medial forearm and hand (ulnar distribution). Upper trunk (C5-C6) involvement is less common and affects shoulder/arm.',
      ),
      QuizQuestion(
        question: 'The Adson test for thoracic outlet syndrome involves:',
        options: ['Resisted shoulder internal rotation', 'Extending the neck, rotating toward the affected side, and taking a deep breath while palpating the radial pulse', 'Cross-body adduction of the arm', 'Overhead arm elevation for 3 minutes'],
        correctIndex: 1,
        explanation: 'Adson\'s test: extend the neck, rotate toward the affected side, deep inspiration — palpate the radial pulse. Diminished pulse or reproduction of symptoms = positive. However, false positive rates are high (~50% of normals).',
      ),
      QuizQuestion(
        question: 'In acromioclavicular joint separations, a Rockwood Type III involves:',
        options: ['AC ligament sprain only', 'AC ligament tear with CC ligaments intact', 'Complete AC and CC ligament disruption with clavicle elevated 25-100%', 'Posterior dislocation of the clavicle'],
        correctIndex: 2,
        explanation: 'Rockwood classification: Type I = AC sprain. Type II = AC torn, CC intact. Type III = both AC and CC disrupted, clavicle elevated 25-100% (controversial for surgical vs conservative). Types IV-VI involve more severe displacement and usually require surgery.',
      ),
    ],
  ),

  // ── Musculoskeletal: Hand ──
  'Musculoskeletal: Hand': const EpisodeQuiz(
    episodeTitle: 'Musculoskeletal: Hand',
    questions: [
      QuizQuestion(
        question: 'De Quervain\'s tenosynovitis involves which tendons?',
        options: ['FDS and FDP', 'EPL and EPB', 'APL and EPB (first dorsal compartment)', 'ECRL and ECRB'],
        correctIndex: 2,
        explanation: 'De Quervain\'s involves the first dorsal compartment: abductor pollicis longus (APL) and extensor pollicis brevis (EPB). The Finkelstein test (ulnar deviation with thumb in fist) reproduces pain. Common in new mothers ("mommy thumb").',
      ),
      QuizQuestion(
        question: 'Trigger finger is caused by:',
        options: ['Tendon rupture', 'Thickening of the A1 pulley with tendon nodule entrapment', 'Dupuytren\'s contracture', 'Joint dislocation'],
        correctIndex: 1,
        explanation: 'Trigger finger results from thickening of the A1 pulley and/or nodule formation on the flexor tendon. The tendon catches as it passes through the narrowed pulley, causing clicking, locking, or a fixed flexion contracture.',
      ),
      QuizQuestion(
        question: 'Dupuytren\'s contracture primarily involves:',
        options: ['The flexor tendons', 'The palmar fascia (palmar aponeurosis)', 'The extensor tendons', 'The joint capsule'],
        correctIndex: 1,
        explanation: 'Dupuytren\'s is a fibroproliferative disorder of the palmar fascia causing nodules and cords that progressively flex the MCP and PIP joints. The ring finger is most commonly affected. Risk factors include Northern European descent, diabetes, alcohol use, and smoking.',
      ),
      QuizQuestion(
        question: 'A Gamekeeper\'s (Skier\'s) thumb involves injury to which structure?',
        options: ['Radial collateral ligament of the thumb MCP', 'Ulnar collateral ligament of the thumb MCP', 'Volar plate of the thumb IP joint', 'Scapholunate ligament'],
        correctIndex: 1,
        explanation: 'Gamekeeper\'s thumb is a sprain/tear of the UCL of the thumb MCP joint. Caused by forceful abduction (ski pole falls, breaking a fall). A Stener lesion (adductor aponeurosis interposition) requires surgical repair as it prevents ligament healing.',
      ),
      QuizQuestion(
        question: 'The scaphoid fracture is significant because:',
        options: ['It is the largest carpal bone', 'Its retrograde blood supply puts it at high risk for avascular necrosis', 'It articulates with no other carpal bones', 'It is always visible on initial X-ray'],
        correctIndex: 1,
        explanation: 'The scaphoid has a retrograde blood supply (entering distally via the dorsal ridge). Proximal pole fractures are at highest risk for AVN. Scaphoid fractures may not be visible on initial X-rays — suspect with anatomical snuffbox tenderness and repeat imaging at 2 weeks or get MRI.',
      ),
    ],
  ),

  // ── Musculoskeletal: Hip 1 ──
  'Musculoskeletal: Hip 1': const EpisodeQuiz(
    episodeTitle: 'Musculoskeletal: Hip 1',
    questions: [
      QuizQuestion(
        question: 'The blood supply to the femoral head primarily comes from the:',
        options: ['Foveal artery (ligamentum teres)', 'Medial femoral circumflex artery', 'Obturator artery', 'Superior gluteal artery'],
        correctIndex: 1,
        explanation: 'The medial femoral circumflex artery provides the primary blood supply to the femoral head via the retinacular vessels. Femoral neck fractures can disrupt this supply, causing AVN. The foveal artery (via ligamentum teres) provides only a small contribution.',
      ),
      QuizQuestion(
        question: 'A positive Trendelenburg sign indicates weakness of which muscle?',
        options: ['Iliopsoas', 'Gluteus maximus', 'Gluteus medius', 'Quadriceps femoris'],
        correctIndex: 2,
        explanation: 'A positive Trendelenburg sign occurs when the pelvis drops on the unsupported side during single-leg stance, indicating gluteus medius weakness on the stance side. The gluteus medius (L5, superior gluteal nerve) is the primary hip abductor that stabilizes the pelvis during gait.',
      ),
      QuizQuestion(
        question: 'Femoral neck fractures are classified using the Garden classification. Garden Type IV indicates:',
        options: ['Incomplete/valgus impacted fracture', 'Complete but non-displaced fracture', 'Complete with partial displacement', 'Complete fracture with full displacement'],
        correctIndex: 3,
        explanation: 'Garden classification: Type I = incomplete/impacted (good prognosis). Type II = complete, non-displaced. Type III = complete, partially displaced. Type IV = completely displaced (highest AVN risk). Types III and IV typically require arthroplasty rather than fixation.',
      ),
      QuizQuestion(
        question: 'After total hip arthroplasty with a posterior approach, which movement is restricted to prevent dislocation?',
        options: ['Hip extension and external rotation', 'Hip flexion >90°, adduction, and internal rotation', 'Hip abduction and external rotation', 'Hip flexion <45° and abduction'],
        correctIndex: 1,
        explanation: 'Posterior approach hip precautions: avoid flexion >90°, adduction past midline, and internal rotation. These positions stress the posterior capsule repair. An elevated toilet seat, hip abduction pillow, and avoiding low chairs are standard precautions.',
      ),
      QuizQuestion(
        question: 'Avascular necrosis of the femoral head is most commonly associated with which risk factor?',
        options: ['Diabetes mellitus', 'Corticosteroid use', 'Smoking', 'Osteoarthritis'],
        correctIndex: 1,
        explanation: 'Corticosteroid use is the most common non-traumatic cause of femoral head AVN. Other risk factors include alcohol abuse, sickle cell disease, systemic lupus, and femoral neck fractures. Steroid-induced AVN is thought to result from fat emboli and increased intraosseous pressure.',
      ),
    ],
  ),

  // ── Musculoskeletal: Hip 2 ──
  'Musculoskeletal: Hip 2': const EpisodeQuiz(
    episodeTitle: 'Musculoskeletal: Hip 2',
    questions: [
      QuizQuestion(
        question: 'Greater trochanteric pain syndrome (formerly trochanteric bursitis) most commonly involves:',
        options: ['Iliopsoas tendon inflammation', 'Gluteus medius/minimus tendinopathy', 'Hamstring tendon avulsion', 'IT band snapping'],
        correctIndex: 1,
        explanation: 'Greater trochanteric pain syndrome is now understood to primarily involve gluteus medius and minimus tendinopathy rather than isolated bursitis. The tendons insert on the greater trochanter and can undergo degenerative changes similar to rotator cuff disease ("rotator cuff of the hip").',
      ),
      QuizQuestion(
        question: 'The FABER (Patrick) test assesses for pathology in which structures?',
        options: ['Quadriceps tendon and patella', 'Hip joint and sacroiliac joint', 'Lumbar spine and sciatic nerve', 'Knee meniscus and ACL'],
        correctIndex: 1,
        explanation: 'FABER = Flexion, ABduction, External Rotation. Pain in the groin = hip joint pathology. Pain in the posterior buttock = sacroiliac joint pathology. This test stresses both structures simultaneously.',
      ),
      QuizQuestion(
        question: 'Femoroacetabular impingement (FAI) of the cam type involves:',
        options: ['Excessive acetabular coverage (overcoverage)', 'Abnormal bony prominence on the femoral head-neck junction', 'Labral hypertrophy', 'Femoral head AVN'],
        correctIndex: 1,
        explanation: 'Cam impingement: abnormal bone on the femoral head-neck junction (loss of normal concavity) that jams into the acetabulum during flexion. Pincer impingement: excessive acetabular coverage. Many patients have mixed (cam + pincer) type.',
      ),
      QuizQuestion(
        question: 'Piriformis syndrome can mimic sciatica because the sciatic nerve:',
        options: ['Originates from the piriformis muscle', 'Passes through or under the piriformis muscle', 'Is compressed by the piriformis at the knee', 'Is a branch of the piriformis nerve'],
        correctIndex: 1,
        explanation: 'The sciatic nerve typically passes beneath the piriformis muscle. In anatomic variants (~15-20% of population), the nerve (or its peroneal division) may pass through or above the piriformis. Spasm or hypertrophy of the piriformis can compress the nerve, causing buttock pain radiating down the leg.',
      ),
      QuizQuestion(
        question: 'Stress fractures of the femoral neck on the tension side (superior/lateral) are important because:',
        options: ['They always heal with rest alone', 'They are at higher risk of displacement and require surgical fixation', 'They are less painful than compression-side fractures', 'They only occur in elderly patients'],
        correctIndex: 1,
        explanation: 'Tension-side (superior) femoral neck stress fractures are at high risk for displacement and completion — they require prophylactic surgical fixation. Compression-side (inferior/medial) fractures are lower risk and can often be managed conservatively with protected weight-bearing.',
      ),
    ],
  ),

  // ── Musculoskeletal: Hip 3 ──
  'Musculoskeletal: Hip 3': const EpisodeQuiz(
    episodeTitle: 'Musculoskeletal: Hip 3',
    questions: [
      QuizQuestion(
        question: 'Legg-Calve-Perthes disease is avascular necrosis of the femoral head in which population?',
        options: ['Elderly women with osteoporosis', 'Adolescent athletes', 'Children ages 4-10 (peak 5-7)', 'Young adults on corticosteroids'],
        correctIndex: 2,
        explanation: 'Legg-Calve-Perthes is idiopathic AVN of the femoral head in children ages 4-10, with peak at 5-7 years. It is 5x more common in boys. The child presents with a painless limp and limited hip abduction/internal rotation.',
      ),
      QuizQuestion(
        question: 'Slipped capital femoral epiphysis (SCFE) most commonly presents in which demographic?',
        options: ['Thin, athletic adolescent girls', 'Overweight adolescent boys (ages 10-16)', 'Toddlers learning to walk', 'Elderly patients after falls'],
        correctIndex: 1,
        explanation: 'SCFE occurs in overweight adolescents (10-16 years), more common in boys. The femoral head "slips" posteriorly and inferiorly relative to the femoral neck. Classic presentation: knee or groin pain with a limp. Obligate external rotation with flexion is pathognomonic.',
      ),
      QuizQuestion(
        question: 'Iliotibial band syndrome causes pain at which location?',
        options: ['Greater trochanter', 'Lateral knee at the femoral epicondyle', 'Medial knee', 'Anterior hip'],
        correctIndex: 1,
        explanation: 'IT band syndrome causes lateral knee pain at the femoral epicondyle, where the IT band snaps over the bony prominence during flexion-extension. It is common in runners and cyclists. Ober\'s test assesses IT band tightness.',
      ),
      QuizQuestion(
        question: 'The Thomas test assesses for:',
        options: ['Hamstring tightness', 'Hip flexion contracture', 'Sacroiliac joint dysfunction', 'Quadriceps weakness'],
        correctIndex: 1,
        explanation: 'The Thomas test: supine, flex the contralateral hip to flatten the lumbar lordosis. If the tested leg rises off the table, a hip flexion contracture is present (tight iliopsoas). This is common in wheelchair users and patients with prolonged bed rest.',
      ),
      QuizQuestion(
        question: 'Snapping hip syndrome (coxa saltans) from the iliotibial band involves snapping over which structure?',
        options: ['The acetabular labrum', 'The greater trochanter (external type)', 'The iliopsoas tendon', 'The femoral head'],
        correctIndex: 1,
        explanation: 'External snapping hip: the IT band or gluteus maximus snaps over the greater trochanter. Internal snapping hip: the iliopsoas tendon snaps over the iliopectineal eminence or femoral head. Intra-articular: labral tears or loose bodies.',
      ),
    ],
  ),

  // ── Musculoskeletal: Knee 1 ──
  'Musculoskeletal: Knee 1': const EpisodeQuiz(
    episodeTitle: 'Musculoskeletal: Knee 1',
    questions: [
      QuizQuestion(
        question: 'The anterior cruciate ligament (ACL) primarily resists:',
        options: ['Posterior tibial translation', 'Anterior tibial translation', 'Valgus stress', 'Varus stress'],
        correctIndex: 1,
        explanation: 'The ACL prevents anterior translation of the tibia on the femur. It is tested with the Lachman test (most sensitive) and anterior drawer test. ACL tears are common in cutting/pivoting sports and have a female predominance (3-6x higher risk).',
      ),
      QuizQuestion(
        question: 'The Lachman test is considered more sensitive than the anterior drawer test for ACL tears because:',
        options: ['It tests at full extension', 'At 20-30° flexion, the hamstrings are relaxed and can\'t mask laxity', 'It tests the posterior cruciate ligament simultaneously', 'It requires less examiner skill'],
        correctIndex: 1,
        explanation: 'The Lachman test is performed at 20-30° flexion where hamstring guarding is minimized. The anterior drawer (90° flexion) allows the hamstrings to act as ACL synergists, potentially masking a tear. Lachman sensitivity is ~85-95% vs ~60-70% for anterior drawer.',
      ),
      QuizQuestion(
        question: 'The "unhappy triad" (O\'Donoghue triad) involves injury to which three structures?',
        options: ['ACL, LCL, and lateral meniscus', 'ACL, MCL, and medial meniscus', 'PCL, MCL, and lateral meniscus', 'ACL, PCL, and medial meniscus'],
        correctIndex: 1,
        explanation: 'The classic unhappy triad: ACL tear + MCL tear + medial meniscus tear. It results from a valgus force with external rotation (e.g., a lateral blow to the knee). Note: some modern literature shows the lateral meniscus may be more commonly injured than medial.',
      ),
      QuizQuestion(
        question: 'The McMurray test evaluates which knee structure?',
        options: ['ACL', 'PCL', 'Meniscus', 'MCL'],
        correctIndex: 2,
        explanation: 'McMurray\'s test: with the knee flexed, apply valgus + external rotation (medial meniscus) or varus + internal rotation (lateral meniscus) while extending. A pop or click with pain = positive for meniscal tear.',
      ),
      QuizQuestion(
        question: 'The PCL is best tested with which maneuver?',
        options: ['Lachman test', 'Anterior drawer test', 'Posterior drawer test / posterior sag sign', 'Pivot shift test'],
        correctIndex: 2,
        explanation: 'The posterior drawer test: at 90° flexion, push the tibia posteriorly. PCL tears also show a posterior sag sign — with knees flexed at 90°, the tibial plateau sags posteriorly compared to the uninjured side. Dashboard injuries (tibia pushed back) are the classic mechanism.',
      ),
    ],
  ),

  // ── Musculoskeletal: Knee 2 ──
  'Musculoskeletal: Knee 2': const EpisodeQuiz(
    episodeTitle: 'Musculoskeletal: Knee 2',
    questions: [
      QuizQuestion(
        question: 'Patellofemoral pain syndrome is the most common cause of anterior knee pain. Which of the following is a key contributing factor?',
        options: ['ACL deficiency', 'Weak vastus medialis obliquus (VMO)', 'Hamstring overactivity', 'Lateral meniscus tear'],
        correctIndex: 1,
        explanation: 'VMO weakness allows the patella to track laterally, increasing patellofemoral contact pressures. VMO strengthening (especially terminal knee extension and isometric quad sets) is central to treatment. Other factors include IT band tightness, increased Q-angle, and femoral anteversion.',
      ),
      QuizQuestion(
        question: 'The Q-angle is measured from the ASIS to the center of the patella to the tibial tubercle. An increased Q-angle is associated with:',
        options: ['MCL instability', 'Lateral patellar tracking and patellofemoral pain', 'ACL deficiency', 'Posterior knee pain'],
        correctIndex: 1,
        explanation: 'An increased Q-angle (normal: ~14° males, ~17° females) creates a lateral vector force on the patella during quadriceps contraction, promoting lateral tracking and patellofemoral pain. Women have larger Q-angles due to wider pelves.',
      ),
      QuizQuestion(
        question: 'Osgood-Schlatter disease involves inflammation at which location?',
        options: ['Inferior pole of the patella', 'Tibial tubercle apophysis', 'Femoral condyle', 'Popliteal fossa'],
        correctIndex: 1,
        explanation: 'Osgood-Schlatter is a traction apophysitis at the tibial tubercle where the patellar tendon inserts. It occurs in active adolescents during growth spurts. Sinding-Larsen-Johansson is the counterpart at the inferior pole of the patella.',
      ),
      QuizQuestion(
        question: 'Baker\'s cyst (popliteal cyst) is a fluid collection that communicates with which structure?',
        options: ['Infrapatellar bursa', 'Semimembranosus-gastrocnemius bursa (knee joint capsule)', 'Pes anserine bursa', 'Prepatellar bursa'],
        correctIndex: 1,
        explanation: 'Baker\'s cysts arise from the semimembranosus-gastrocnemius bursa, which communicates with the knee joint through a one-way valve. They are usually secondary to intra-articular pathology (meniscal tears, arthritis). Rupture can mimic DVT (pseudothrombophlebitis).',
      ),
      QuizQuestion(
        question: 'Pes anserine bursitis causes pain at which location?',
        options: ['Lateral knee', 'Posterior knee', 'Medial knee, approximately 2 inches below the joint line', 'Anterior knee at the tibial tubercle'],
        correctIndex: 2,
        explanation: 'The pes anserinus ("goose foot") is the conjoined tendon insertion of the sartorius, gracilis, and semitendinosus on the medial proximal tibia, ~2 inches below the joint line. Bursitis causes medial knee pain, especially with stair climbing. Common in obese women with knee OA.',
      ),
    ],
  ),

  // ── Musculoskeletal: Knee 3 ──
  'Musculoskeletal: Knee 3': const EpisodeQuiz(
    episodeTitle: 'Musculoskeletal: Knee 3',
    questions: [
      QuizQuestion(
        question: 'Total knee arthroplasty is indicated for which of the following?',
        options: ['Isolated ACL tear', 'Severe tricompartmental osteoarthritis failing conservative management', 'Osgood-Schlatter disease', 'Acute meniscal tear'],
        correctIndex: 1,
        explanation: 'TKA is indicated for severe symptomatic OA (typically tricompartmental) that has failed conservative treatment including weight loss, PT, injections, and medications. Unicompartmental (partial) knee replacement may be considered for isolated medial or lateral compartment disease.',
      ),
      QuizQuestion(
        question: 'After total knee arthroplasty, achieving which degree of knee flexion is considered a functional goal?',
        options: ['60°', '90°', '120°', '135°'],
        correctIndex: 2,
        explanation: 'A functional goal of 120° flexion allows patients to perform most daily activities. Minimum needed: 67° for swing phase of gait, 83° for stairs, 93° to rise from a chair, ~105-110° for bathing. 120° is an excellent outcome.',
      ),
      QuizQuestion(
        question: 'Prepatellar bursitis ("housemaid\'s knee") is caused by:',
        options: ['ACL tear', 'Repeated kneeling on a hard surface', 'Quadriceps tendon rupture', 'Meniscal degeneration'],
        correctIndex: 1,
        explanation: 'Prepatellar bursitis results from repetitive friction/pressure over the anterior patella, classically from kneeling (housemaid, roofer, plumber). Septic bursitis must be excluded by aspiration if warmth, erythema, or fever are present.',
      ),
      QuizQuestion(
        question: 'The valgus stress test at the knee evaluates which structure?',
        options: ['ACL', 'PCL', 'MCL (medial collateral ligament)', 'LCL (lateral collateral ligament)'],
        correctIndex: 2,
        explanation: 'Valgus stress test: apply a lateral-to-medial force at the knee (pushing the knee medially). Laxity at 30° flexion = isolated MCL injury. Laxity at full extension = MCL + possible cruciate/capsular involvement (more severe).',
      ),
      QuizQuestion(
        question: 'A locked knee that cannot fully extend is most likely caused by:',
        options: ['ACL tear', 'MCL sprain', 'Bucket-handle meniscal tear', 'Patellofemoral syndrome'],
        correctIndex: 2,
        explanation: 'A bucket-handle meniscal tear is a displaced vertical longitudinal tear that flips into the intercondylar notch, mechanically blocking full extension ("locked knee"). This is a surgical urgency requiring arthroscopic reduction and repair/resection.',
      ),
    ],
  ),

  // ── Musculoskeletal: Lower Leg ──
  'Musculoskeletal: Lower Leg': const EpisodeQuiz(
    episodeTitle: 'Musculoskeletal: Lower Leg',
    questions: [
      QuizQuestion(
        question: 'Acute compartment syndrome requires emergent fasciotomy when compartment pressure exceeds:',
        options: ['10 mmHg', '20 mmHg', '30 mmHg (or within 30 mmHg of diastolic pressure)', '50 mmHg'],
        correctIndex: 2,
        explanation: 'Compartment syndrome requires fasciotomy when pressure >30 mmHg or within 30 mmHg of diastolic (delta P <30). The 5 P\'s (pain out of proportion, pain with passive stretch, paresthesias, pallor, pulselessness) are classic but pulselessness is a late and ominous sign.',
      ),
      QuizQuestion(
        question: 'The most reliable early clinical finding of acute compartment syndrome is:',
        options: ['Pulselessness', 'Paralysis', 'Pain with passive stretch of the affected compartment muscles', 'Pallor'],
        correctIndex: 2,
        explanation: 'Pain with passive stretch of the muscles in the affected compartment is the earliest and most reliable clinical sign. For the anterior compartment, passively plantarflexing the foot stretches the tibialis anterior. Waiting for pulselessness means irreversible damage has occurred.',
      ),
      QuizQuestion(
        question: 'Medial tibial stress syndrome (shin splints) involves:',
        options: ['Anterior compartment syndrome', 'Stress reaction at the posteromedial tibial cortex', 'Achilles tendon rupture', 'Peroneal nerve entrapment'],
        correctIndex: 1,
        explanation: 'Medial tibial stress syndrome is a stress reaction/periostitis at the posteromedial tibial border, typically in the distal two-thirds. It is caused by repetitive loading (running on hard surfaces). It exists on a continuum with tibial stress fractures.',
      ),
      QuizQuestion(
        question: 'The anterior compartment of the leg contains which muscles?',
        options: ['Gastrocnemius and soleus', 'Tibialis posterior and FDL', 'Tibialis anterior, EHL, EDL, and peroneus tertius', 'Peroneus longus and brevis'],
        correctIndex: 2,
        explanation: 'The anterior compartment (deep peroneal nerve, anterior tibial artery) contains: tibialis anterior (dorsiflexion/inversion), EHL (great toe extension), EDL (toe extension), and peroneus tertius (dorsiflexion/eversion). Injury causes foot drop.',
      ),
      QuizQuestion(
        question: 'Chronic exertional compartment syndrome differs from acute compartment syndrome in that:',
        options: ['It requires emergent fasciotomy', 'It causes irreversible muscle necrosis', 'Symptoms resolve with rest and recur with exercise', 'It only affects the posterior compartment'],
        correctIndex: 2,
        explanation: 'Chronic exertional compartment syndrome causes exercise-induced pain that resolves with rest (usually within 15-30 minutes). It does not cause permanent damage. Diagnosis requires pre- and post-exercise compartment pressure measurements. Fasciotomy is curative for refractory cases.',
      ),
    ],
  ),

  // ── Musculoskeletal: Spine 1 ──
  'Musculoskeletal: Spine 1': const EpisodeQuiz(
    episodeTitle: 'Musculoskeletal: Spine 1',
    questions: [
      QuizQuestion(
        question: 'A posterolateral disc herniation at L4-L5 will most commonly compress which nerve root?',
        options: ['L3', 'L4', 'L5', 'S1'],
        correctIndex: 2,
        explanation: 'In the lumbar spine, posterolateral disc herniations compress the traversing (lower) nerve root. An L4-L5 disc herniates into the L5 nerve root. A far lateral (foraminal) herniation would compress the exiting (upper) root — L4 in this case.',
      ),
      QuizQuestion(
        question: 'The straight leg raise (SLR) test is considered positive when it reproduces radicular symptoms at what angle range?',
        options: ['0-20°', '30-70°', '80-90°', 'Any angle'],
        correctIndex: 1,
        explanation: 'A positive SLR reproduces radicular pain (not just hamstring tightness) between 30-70°. Below 30°, the nerve roots are not yet under tension. Above 70°, pelvic rotation contributes more than nerve root stretch. A positive crossed SLR (contralateral leg raise) is more specific for disc herniation.',
      ),
      QuizQuestion(
        question: 'An L5 radiculopathy presents with weakness of:',
        options: ['Knee extension and hip flexion', 'Ankle dorsiflexion and great toe extension (EHL)', 'Ankle plantarflexion and knee flexion', 'Hip abduction and knee extension'],
        correctIndex: 1,
        explanation: 'L5 radiculopathy: weakness of ankle dorsiflexion (tibialis anterior), great toe extension (EHL), hip abduction, and foot inversion. Sensory loss is on the dorsum of the foot. The L5 reflex is difficult to test (medial hamstring, often unreliable).',
      ),
      QuizQuestion(
        question: 'Cauda equina syndrome is a surgical emergency presenting with:',
        options: ['Unilateral radiculopathy', 'Bilateral leg pain, saddle anesthesia, and bowel/bladder dysfunction', 'Isolated back pain without neurological deficits', 'Cervical myelopathy'],
        correctIndex: 1,
        explanation: 'Cauda equina syndrome: bilateral leg pain/weakness, saddle anesthesia (perineal numbness), and bowel/bladder dysfunction (typically urinary retention). It requires emergent MRI and surgical decompression within 24-48 hours to prevent permanent deficits.',
      ),
      QuizQuestion(
        question: 'The S1 nerve root is tested by which deep tendon reflex?',
        options: ['Patellar (knee jerk)', 'Achilles (ankle jerk)', 'Biceps', 'Brachioradialis'],
        correctIndex: 1,
        explanation: 'S1 = Achilles reflex, ankle plantarflexion, eversion. L4 = patellar reflex, knee extension. S1 radiculopathy is the most common lumbar radiculopathy (L5-S1 disc is the most commonly herniated lumbar disc).',
      ),
    ],
  ),

  // ── Musculoskeletal: Spine 2 ──
  'Musculoskeletal: Spine 2': const EpisodeQuiz(
    episodeTitle: 'Musculoskeletal: Spine 2',
    questions: [
      QuizQuestion(
        question: 'Cervical myelopathy is characterized by which finding?',
        options: ['Unilateral arm weakness only', 'Upper motor neuron signs in the lower extremities (spasticity, hyperreflexia, Babinski)', 'Isolated neck pain without neurological deficits', 'Normal gait with isolated hand numbness'],
        correctIndex: 1,
        explanation: 'Cervical myelopathy compresses the spinal cord, producing UMN signs below the level of compression: spastic gait, hyperreflexia, Babinski sign, Hoffman sign, and clumsiness. It is a surgical condition — progressive myelopathy requires decompression.',
      ),
      QuizQuestion(
        question: 'Lumbar spinal stenosis classically presents with:',
        options: ['Constant pain unrelated to activity', 'Neurogenic claudication that improves with flexion (shopping cart sign)', 'Acute onset foot drop', 'Pain that worsens with sitting'],
        correctIndex: 1,
        explanation: 'Neurogenic claudication: bilateral leg pain/heaviness with walking that improves with flexion (leaning on a shopping cart, sitting). Flexion opens the spinal canal. Extension narrows it. This distinguishes it from vascular claudication (which improves with standing still, not flexion).',
      ),
      QuizQuestion(
        question: 'The Spurling test for cervical radiculopathy involves:',
        options: ['Flexing the neck while applying axial compression', 'Extending and laterally flexing the neck toward the affected side with axial compression', 'Rotating the neck away from the affected side', 'Applying traction to the neck'],
        correctIndex: 1,
        explanation: 'Spurling\'s test: extend, laterally flex toward the symptomatic side, and apply axial compression. This narrows the neural foramen and reproduces radicular symptoms. It has high specificity (~93%) but moderate sensitivity (~40-60%) for cervical radiculopathy.',
      ),
      QuizQuestion(
        question: 'Spondylolisthesis refers to:',
        options: ['A fracture of the vertebral body', 'Forward slippage of one vertebra on another', 'Disc herniation into the spinal canal', 'Lateral curvature of the spine'],
        correctIndex: 1,
        explanation: 'Spondylolisthesis is anterior slippage of a vertebra relative to the one below. It is most common at L5-S1. Graded I-V by percentage of slip (Meyerding classification). Isthmic type (pars defect/spondylolysis) is most common in young athletes. Degenerative type is most common in older adults.',
      ),
      QuizQuestion(
        question: 'Spondylolysis is a defect in which part of the vertebra?',
        options: ['Vertebral body', 'Spinous process', 'Pars interarticularis', 'Transverse process'],
        correctIndex: 2,
        explanation: 'Spondylolysis is a stress fracture/defect of the pars interarticularis, most common at L5. Bilateral pars defects can lead to spondylolisthesis. The "Scotty dog" sign on oblique X-ray shows the pars defect as a collar on the dog. Common in gymnasts, football linemen, and dancers.',
      ),
    ],
  ),

  // ── Musculoskeletal: Spine 3 ──
  'Musculoskeletal: Spine 3': const EpisodeQuiz(
    episodeTitle: 'Musculoskeletal: Spine 3',
    questions: [
      QuizQuestion(
        question: 'A C6 radiculopathy presents with weakness of:',
        options: ['Shoulder abduction and elbow flexion', 'Wrist extension and biceps (elbow flexion)', 'Triceps and wrist flexion', 'Hand intrinsic muscles'],
        correctIndex: 1,
        explanation: 'C6 radiculopathy: weakness of wrist extension (ECRL/ECRB) and biceps (elbow flexion). Sensory loss is in the thumb and lateral forearm. The biceps and brachioradialis reflexes are diminished. The most common cause is C5-C6 disc herniation.',
      ),
      QuizQuestion(
        question: 'The Waddell signs are used to identify:',
        options: ['Cervical myelopathy', 'Non-organic (psychogenic) components of low back pain', 'Cauda equina syndrome', 'Lumbar spinal stenosis'],
        correctIndex: 1,
        explanation: 'Waddell signs (5 categories): superficial/non-anatomic tenderness, simulation tests (axial loading, rotation), distraction tests (SLR discrepancy), regional disturbances (non-dermatomal weakness/sensory loss), and overreaction. Three or more positive categories suggest non-organic factors.',
      ),
      QuizQuestion(
        question: 'Ankylosing spondylitis most commonly begins with:',
        options: ['Cervical spine pain', 'Lumbar disc herniation', 'Sacroiliac joint inflammation (sacroiliitis)', 'Peripheral joint arthritis'],
        correctIndex: 2,
        explanation: 'Ankylosing spondylitis (HLA-B27 associated) typically begins with bilateral sacroiliitis in young adults (20-30 years). It progresses cranially with bamboo spine appearance. Morning stiffness >30 minutes that improves with exercise is characteristic. It affects males more than females.',
      ),
      QuizQuestion(
        question: 'The Jefferson fracture involves:',
        options: ['Dens (odontoid) fracture', 'Burst fracture of the C1 (atlas) ring', 'Hangman\'s fracture of C2', 'Compression fracture of C7'],
        correctIndex: 1,
        explanation: 'The Jefferson fracture is a burst fracture of the C1 (atlas) ring from axial loading (diving into shallow water, hitting head on car roof). It typically involves fractures of both anterior and posterior arches. It is usually stable because the ring fragments spread outward.',
      ),
      QuizQuestion(
        question: 'A hangman\'s fracture involves which vertebra?',
        options: ['C1 (atlas)', 'C2 (axis) — bilateral pars interarticularis fractures', 'C3', 'C7'],
        correctIndex: 1,
        explanation: 'A hangman\'s fracture is a bilateral fracture of the C2 pars interarticularis (pedicles) from hyperextension and axial loading. Despite the name, it is now most commonly caused by motor vehicle accidents. It is often neurologically intact because the fracture widens the canal.',
      ),
    ],
  ),
};
