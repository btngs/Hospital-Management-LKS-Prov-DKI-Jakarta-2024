CREATE DATABASE DESKTOP_XX -- where XX is your PC number
GO
USE DESKTOP_XX
GO

CREATE TABLE [user](
    id                      INT             NOT NULL    IDENTITY,
    username                VARCHAR(50)     NOT NULL,
    [password]              CHAR(128)       NOT NULL,
    last_login_at           DATETIME        NOT NULL,
	deleted_at              DATETIME,
    PRIMARY KEY (id),
    CONSTRAINT UNQ_username UNIQUE (username)
);

CREATE TABLE [icd-11](
	id						INT				NOT NULL	IDENTITY,
	[name]					VARCHAR(200)	NOT NULL,
	[description]			TEXT,
	created_at				DATETIME		NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	last_updated_at			DATETIME,
	deleted_at				DATETIME,
	PRIMARY KEY (id),
);

CREATE TABLE [icd-11_exclusion](
	id						INT				NOT NULL	IDENTITY,
	[icd-11_id]				INT				NOT NULL,
	exclusion				TEXT			NOT NULL,
	created_at				DATETIME		NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	last_updated_at			DATETIME,
	deleted_at				DATETIME,
	PRIMARY KEY (id),
	FOREIGN KEY ([icd-11_id]) 				REFERENCES [icd-11](id),
);

CREATE TABLE [doctor_category](
	id						INT				NOT NULL	IDENTITY,
	category				VARCHAR(200)	NOT NULL,
	created_at				DATETIME		NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	last_updated_at			DATETIME,
	deleted_at				DATETIME,
	PRIMARY KEY (id),
);

CREATE TABLE [icd-11_doctor_recommendation](
	id						INT				NOT NULL	IDENTITY,
	[icd-11_id]				INT				NOT NULL,
	[doctor_category_id]	INT				NOT NULL,
	created_at				DATETIME		NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	last_updated_at			DATETIME,
	deleted_at				DATETIME,
	PRIMARY KEY (id),
	FOREIGN KEY ([icd-11_id]) 				REFERENCES [icd-11](id),
	FOREIGN KEY ([doctor_category_id]) 		REFERENCES [doctor_category](id),
);

CREATE TABLE [doctor](
	id						INT				NOT NULL	IDENTITY,
	[doctor_category_id]	INT				NOT NULL,
	[name]					VARCHAR(200)	NOT NULL,
	phone_number			VARCHAR(200)	NOT NULL,
	email					VARCHAR(200)	NOT NULL,
	city_of_birth			VARCHAR(200)	NOT NULL,
	date_of_birth			DATETIME		NOT NULL,
	[address]				VARCHAR(200)	NOT NULL,
	gender					VARCHAR(50)		NOT NULL,
	assigned_room			VARCHAR(50)		NOT NULL,
	created_at				DATETIME		NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	last_updated_at			DATETIME,
	deleted_at				DATETIME,
	PRIMARY KEY (id),
	FOREIGN KEY ([doctor_category_id]) 		REFERENCES [doctor_category](id),
	CONSTRAINT CHK_gender_doctor CHECK (gender = 'Male' OR gender = 'Female')
);

CREATE TABLE [patient](
	id						INT				NOT NULL	IDENTITY,
	[name]					VARCHAR(200)	NOT NULL,
	phone_number			VARCHAR(200)	NOT NULL,
	email					VARCHAR(200)	NOT NULL,
	city_of_birth			VARCHAR(200)	NOT NULL,
	date_of_birth			DATETIME		NOT NULL,
	[address]				VARCHAR(200)	NOT NULL,
	gender					VARCHAR(50)		NOT NULL,
	blood_type				VARCHAR(10)		NOT NULL,
	created_at				DATETIME		NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	last_updated_at			DATETIME,
	deleted_at				DATETIME,
	PRIMARY KEY (id),
	CONSTRAINT CHK_gender_patient CHECK (gender = 'Male' OR gender = 'Female')
);

CREATE TABLE [meeting](
	id						INT				NOT NULL	IDENTITY,
	[patient_id]			INT				NOT NULL,
	[doctor_id]				INT				NOT NULL,
	room					VARCHAR(50)		NOT NULL,
	[date]					DATE			NOT NULL,
	queue_number			INT				NOT NULL,
	created_at				DATETIME		NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	last_updated_at			DATETIME,
	deleted_at				DATETIME,
	PRIMARY KEY (id),
	FOREIGN KEY ([patient_id]) 				REFERENCES [patient](id),
	FOREIGN KEY ([doctor_id]) 				REFERENCES [doctor](id),
);

CREATE TABLE [patient_record](
	id						INT				NOT NULL	IDENTITY,
	[patient_id]			INT				NOT NULL,
	[meeting_id]			INT				NOT NULL,
	notes					TEXT			NOT NULL,
	[date]					DATE			NOT NULL,
	created_at				DATETIME		NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	last_updated_at			DATETIME,
	deleted_at				DATETIME,
	PRIMARY KEY (id),
	FOREIGN KEY ([patient_id]) 				REFERENCES [patient](id),
	FOREIGN KEY ([meeting_id]) 				REFERENCES [meeting](id),
);

CREATE TABLE [payment](
	id						INT				NOT NULL	IDENTITY,
	[meeting_id]			INT				NOT NULL,
	card_holder_name		VARCHAR(50)		NOT NULL,
	primary_account_number	VARCHAR(50)		NOT NULL,
	expiration_date			DATE			NOT NULL,
	service_code			INT				NOT NULL,
	total_payment			DECIMAL(10,2)	NOT NULL,
	created_at				DATETIME		NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	last_updated_at			DATETIME,
	deleted_at				DATETIME,
	PRIMARY KEY (id),
	FOREIGN KEY ([meeting_id]) 				REFERENCES [meeting](id),
	CONSTRAINT CHK_service_code CHECK (service_code >= 100 AND service_code <= 999)
)

CREATE TABLE [payment_detail](
	id						INT				NOT NULL	IDENTITY,
	[payment_id]			INT				NOT NULL,
	item					VARCHAR(200)	NOT NULL,
	nominal					DECIMAL(10,2)	NOT NULL,
	notes					TEXT,
	created_at				DATETIME		NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	last_updated_at			DATETIME,
	deleted_at				DATETIME,
	PRIMARY KEY (id),
	FOREIGN KEY ([payment_id]) 				REFERENCES [payment](id),
)

-- password is the same as username 
INSERT INTO [user] (username, [password], last_login_at) VALUES ('john_doe', 'ad8a7934f46531bc97ce69f8782187eda723a37a8a3b59e402b54f7a69b4f3bc11eced54290af3438ca8ecbacdfb2b9d2c291fce02601a5edcfa07f39376f6eb', '2024-06-01 08:30:00');
INSERT INTO [user] (username, [password], last_login_at) VALUES ('jane_doe', 'c8ee086596a916502888e8b66cab78860f93b2857e318371bf82067666a29856a58830ef8310c28bd7e626bd1459e714f2e2dfc916992b7db2cb09398a1284b0', '2024-06-02 10:15:00');
INSERT INTO [user] (username, [password], last_login_at) VALUES ('michael_smith', '3be973becec42a70b32fabff2dbb49e6bbc6db6544d873cb9e7afd819d50b5ea02678cd279a3be73cfae7edbc40594c109f06ce9cf8bdde9a35d34c4dc10738e', '2024-06-02 12:45:00');
INSERT INTO [user] (username, [password], last_login_at) VALUES ('emily_johnson', '5efa7c5a6c0041b302dc78a8013703a13025ff44c113d3a5b80fd5f23568d604596c01d68e8dac4badd51a37ab5dadeb0133dbf34fbddc751f1d57f5564c7ab1', '2024-06-01 14:20:00');
INSERT INTO [user] (username, [password], last_login_at) VALUES ('david_jones', 'd18c77b89e36efa78ccbbdae2932a4340c7ab2d368c4a1cd84e523c380c9d432fb836b10ef9af41738a9cabd9d2d9612f056f7b9693ba7a8b4f452e3043f5869', '2024-06-02 09:00:00');

INSERT INTO [icd-11]([name], [description]) VALUES('Certain infectious or parasitic diseases', 'This chapter includes certain conditions caused by pathogenic organisms or microorganisms, such as bacteria, viruses, parasites or fungi.')
INSERT INTO [icd-11]([name], [description]) VALUES('Neoplasms', 'An abnormal or uncontrolled cellular proliferation which is not coordinated with an organism''s requirements for normal tissue growth, replacement or repair.')
INSERT INTO [icd-11]([name], [description]) VALUES('Diseases of the blood or blood-forming organs', 'This chapter includes diseases of the blood as well as diseases of blood forming organs.')
INSERT INTO [icd-11]([name], [description]) VALUES('Diseases of the immune system', '')
INSERT INTO [icd-11]([name], [description]) VALUES('Endocrine, nutritional or metabolic diseases', 'This chapter includes endocrine diseases, nutritional diseases as well as metabolic diseases.')
INSERT INTO [icd-11]([name], [description]) VALUES('Mental, behavioural or neurodevelopmental disorders', 'Mental, behavioural and neurodevelopmental disorders are syndromes characterised by clinically significant disturbance in an individual''s cognition, emotional regulation, or behaviour that reflects a dysfunction in the psychological, biological, or developmental processes that underlie mental and behavioural functioning. These disturbances are usually associated with distress or impairment in personal, family, social, educational, occupational, or other important areas of functioning.')
INSERT INTO [icd-11]([name], [description]) VALUES('Sleep-wake disorders', 'Sleep-wake disorders are characterised by difficulty initiating or maintaining sleep (insomnia disorders), excessive sleepiness (hypersomnolence disorders), respiratory disturbance during sleep (sleep-related breathing disorders), disorders of the sleep-wake schedule (circadian rhythm sleep-wake disorders), abnormal movements during sleep (sleep-related movement disorders), or problematic behavioural or physiological events that occur while falling asleep, during sleep, or upon arousal from sleep (parasomnia disorders).')
INSERT INTO [icd-11]([name], [description]) VALUES('Diseases of the nervous system', 'This is a group of conditions characterised as being in or associated with the nervous system.')
INSERT INTO [icd-11]([name], [description]) VALUES('Diseases of the visual system', 'This refers to any diseases of the visual system, which includes the eyes and adnexa, the visual pathways and brain areas, which initiate and control visual perception and visually guided behaviour.')
INSERT INTO [icd-11]([name], [description]) VALUES('Diseases of the ear or mastoid process', 'This chapter contains diseases of the ear and diseases of the mastoid process.')
INSERT INTO [icd-11]([name], [description]) VALUES('Diseases of the circulatory system', 'This refers to diseases of the organ system that passes nutrients (such as amino acids, electrolytes and lymph), gases, hormones, blood cells, etc. to and from cells in the body to help fight diseases, stabilize body temperature and pH, and to maintain homeostasis.')
INSERT INTO [icd-11]([name], [description]) VALUES('Diseases of the respiratory system', '')
INSERT INTO [icd-11]([name], [description]) VALUES('Diseases of the digestive system', '')
INSERT INTO [icd-11]([name], [description]) VALUES('Diseases of the skin', 'Diseases of the skin incorporate conditions affecting the epidermis, its appendages (hair, hair follicle, sebaceous glands, apocrine sweat gland apparatus, eccrine sweat gland apparatus and nails) and associated mucous membranes (conjunctival, oral and genital), the dermis, the cutaneous vasculature and the subcutaneous tissue (subcutis).')
INSERT INTO [icd-11]([name], [description]) VALUES('Diseases of the musculoskeletal system or connective tissue', 'This chapter contains diseases of musculoskeletal system and diseases of connective tissue.')
INSERT INTO [icd-11]([name], [description]) VALUES('Diseases of the genitourinary system', 'Any disease characterised by pathological changes to the genitourinary system.')
INSERT INTO [icd-11]([name], [description]) VALUES('Conditions related to sexual health', '')
INSERT INTO [icd-11]([name], [description]) VALUES('Pregnancy, childbirth or the puerperium', 'A group of conditions characterised as occurring during the period of time from conception to delivery (pregnancy), during labour and delivery (childbirth) or during the approximately six weeks after delivery during which the uterus returns to the original size (puerperium).')
INSERT INTO [icd-11]([name], [description]) VALUES('Certain conditions originating in the perinatal period', 'This chapter includes conditions that have their origin in the perinatal period even though death or morbidity occurs later.')
INSERT INTO [icd-11]([name], [description]) VALUES('Developmental anomalies', 'This chapter includes conditions caused by failure of a particular body site or body system to develop correctly during the antenatal period.')
INSERT INTO [icd-11]([name], [description]) VALUES('Symptoms, signs or clinical findings, not elsewhere classified', 'Clinical findings include those found using physical, laboratory and imaging techniques. Diseases can manifest in many ways and in different body systems. Such specific manifestations may be a reason for treatment or encounter, with or without identifying or addressing the underlying condition. Categories in this chapter include the less well-defined conditions and symptoms that, without the necessary study of the case to establish a final diagnosis, could be designated ''not otherwise specified'', ''unknown aetiology'' or ''transient''.')
INSERT INTO [icd-11]([name], [description]) VALUES('Injury, poisoning or certain other consequences of external causes', 'In the ICD, injury means physical or physiological bodily harm resulting from interaction of the body with energy (mechanical, thermal, electrical, chemical or radiant, or due to extreme pressure) in an amount, or at a rate of transfer, that exceeds physical or physiological tolerance. Injury can also result from lack of vital elements, such as oxygen. Poisoning by and toxic effects of substances are included, as is damage of or due to implanted devices. Injury usually has rapid onset in response to a well-defined event (e.g. a car crash, striking the ground after falling, drinking a strongly alkaline liquid, an overdose of a medication, a burn sustained during a surgical procedure). These events are often referred to as external causes of injury. The injurious energy can, however, originate from the injured person and/or from his or her immediate environment (e.g. a person running on a hot day sustains heat exhaustion), and injury can be caused by the injured person (i.e. intentional self-harm). Injury includes manifestations that are evident immediately after onset, which may persist or not, and manifestations that first become evident at a later date.')
INSERT INTO [icd-11]([name], [description]) VALUES('External causes of morbidity or mortality', 'The WHO definition of an ''injury'' is: ‘Injuries are caused by acute exposure to physical agents such as mechanical energy, heat, electricity, chemicals, and ionizing radiation interacting with the body in amounts or at rates that exceed the threshold of human tolerance. In some cases, (for example, drowning and frostbite), injuries result from the sudden lack of essential agents such as oxygen or heat’. Injuries may be categorized in a number of ways. However, for most analytical purposes and for identifying intervention opportunities, it is especially useful to categorize injuries according to whether or not they were deliberately inflicted and by whom.')

INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(1, 'Infection arising from device, implant or graft, not elsewhere classified (NE83.1)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(3, 'Complications of pregnancy, childbirth or the puerperium (JA00-JB6Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(3, 'Diseases of the immune system (4A00-4B4Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(3, 'Certain conditions originating in the perinatal period (KA00-KD5Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(3, 'Injury, poisoning or certain other consequences of external causes (NA00-NF2Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(3, 'Human immunodeficiency virus disease (1C60-1C62.Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(3, 'Endocrine, nutritional or metabolic diseases (5A00-5D46)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(3, 'Congenital malformations, deformations or chromosomal abnormalities (LA00-LD9Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(3, 'Other diseases of the blood or blood-forming organs or certain disorders involving the immune mechanism complicating pregnancy, childbirth or the puerperium (JB64.1)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(4, 'Complications of pregnancy, childbirth and the puerperium (JA00-JB6Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(4, 'Neoplasms (2A00-2F9Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(4, 'Developmental anomalies (LA00-LD9Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(5, 'Transitory endocrine or metabolic disorders specific to fetus or newborn (KB60-KB6Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(5, 'Pregnancy, childbirth or the puerperium (JA00-JB6Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(6, 'Acute stress reaction (QE84)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(6, 'Uncomplicated bereavement (QE62)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(8, 'Endocrine, nutritional or metabolic diseases (5A00-5D46)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(8, 'Complications of pregnancy, childbirth and the puerperium (JA00-JB6Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(8, 'Certain conditions originating in the perinatal period (KA00-KD5Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(8, 'Injury, poisoning or certain other consequences of external causes (NA00-NF2Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(9, 'Certain conditions originating in the perinatal period (KA00-KD5Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(9, 'Certain infectious or parasitic diseases (1A00-1H0Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(9, 'Complications of pregnancy, childbirth and the puerperium (JA00-JB6Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(9, 'Endocrine, nutritional or metabolic diseases (5A00-5D46)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(9, 'Injury, poisoning or certain other consequences of external causes (NA00-NF2Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(9, 'Posterior cortical atrophy (8A21.0)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(10, 'Complications of pregnancy, childbirth and the puerperium (JA00-JB6Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(10, 'Certain infectious or parasitic diseases (1A00-1H0Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(10, 'Certain conditions originating in the perinatal period (KA00-KD5Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(10, 'Injury, poisoning or certain other consequences of external causes (NA00-NF2Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(10, 'Neoplasms (2A00-2F9Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(10, 'Endocrine, nutritional or metabolic diseases (5A00-5D46)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(11, 'Certain infectious or parasitic diseases (1A00-1H0Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(11, 'Certain conditions originating in the perinatal period (KA00-KD5Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(11, 'Congenital malformations, deformations and chromosomal abnormalities (LA00-LD9Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(11, 'Complications of pregnancy, childbirth and the puerperium (JA00-JB6Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(11, 'Injury, poisoning or certain other consequences of external causes (NA00-NF2Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(11, 'Endocrine, nutritional or metabolic diseases (5A00-5D46)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(12, 'Endocrine, nutritional or metabolic diseases (5A00-5D46)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(12, 'Congenital malformations, deformations and chromosomal abnormalities (LA00-LD9Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(12, 'Injury, poisoning or certain other consequences of external causes (NA00-NF2Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(12, 'Certain conditions originating in the perinatal period (KA00-KD5Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(12, 'Certain infectious or parasitic diseases (1A00-1H0Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(12, 'Complications of pregnancy, childbirth and the puerperium (JA00-JB6Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(13, 'Endocrine, nutritional or metabolic diseases (5A00-5D46)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(13, 'Injury, poisoning or certain other consequences of external causes (NA00-NF2Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(13, 'Neoplasms (2A00-2F9Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(13, 'Certain infectious or parasitic diseases (1A00-1H0Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(13, 'Complications of pregnancy, childbirth and the puerperium (JA00-JB6Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(13, 'Mental, behavioural or neurodevelopmental disorders (6A00-6E8Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(15, 'Injury, poisoning or certain other consequences of external causes (NA00-NF2Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(15, 'Endocrine, nutritional or metabolic diseases (5A00-5D46)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(15, 'Complications of pregnancy, childbirth and the puerperium (JA00-JB6Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(15, 'Certain infectious or parasitic diseases (1A00-1H0Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(15, 'Temporomandibular joint disorders (DA0E.8)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(15, 'Certain conditions originating in the perinatal period (KA00-KD5Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(16, 'Injury, poisoning or certain other consequences of external causes (NA00-NF2Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(16, 'Endocrine, nutritional or metabolic diseases (5A00-5D46)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(16, 'Complications of pregnancy, childbirth and the puerperium (JA00-JB6Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(16, 'Certain infectious or parasitic diseases (1A00-1H0Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(18, 'Postpartum necrosis of pituitary gland (5A61.0)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(18, 'Obstetrical tetanus (1C14)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(18, 'Injury, poisoning or certain other consequences of external causes (NA00-NF2Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(19, 'Endocrine, nutritional or metabolic diseases (5A00-5D46)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(19, 'Congenital malformations, deformations and chromosomal abnormalities (LA00-LD9Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(19, 'Neoplasms (2A00-2F9Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(19, 'Injury, poisoning or certain other consequences of external causes (NA00-NF2Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(19, 'VA Tetanus neonatorum')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(19, 'Congenital gonococcal infection (1A70-1A7Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(19, 'Certain infectious or parasitic diseases - acquired after birth (1A00-1H0Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(19, 'Gastroenteritis or colitis of infectious origin (1A00-1A40.Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(19, 'Hereditary haemolytic anaemia (3A10)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(19, 'Transient hypogammaglobulinaemia of infancy (4A01.03)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(19, 'Certain congenital diseases of the nervous system (8A00-8E7Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(19, 'congenital cardiomyopathy (BC43)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(19, 'Paralytic ileus (DA93.0)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(19, 'Pemphigus neonatorum (EA50)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(19, 'Cradle cap (EH40.00)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(20, 'Inborn errors of metabolism (5C50-5C5Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(21, 'Certain conditions originating in the perinatal period (KA00-KD5Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(21, 'Clinical findings on antenatal screening of mother (JA66)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(22, 'Stress fracture, not elsewhere classified (FB80.A)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(22, 'Pathological fracture, not elsewhere classified (FB80.B)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(22, 'Certain specified obstetric trauma (JB0A)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(22, 'Malunion of fracture (FB80.7)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(22, 'Birth injury (KA40-KA4Z)')
INSERT INTO [icd-11_exclusion]([icd-11_id], exclusion)VALUES(22, 'Nonunion of fracture (FB80.8)')

INSERT INTO [doctor_category] ([category]) VALUES('General Practicioner')
INSERT INTO [doctor_category] ([category]) VALUES('Allergists')
INSERT INTO [doctor_category] ([category]) VALUES('Dermatologists')
INSERT INTO [doctor_category] ([category]) VALUES('Infectious Disease Doctors')
INSERT INTO [doctor_category] ([category]) VALUES('Ophthalmologists')
INSERT INTO [doctor_category] ([category]) VALUES('Obstetrician/Gynecologists')
INSERT INTO [doctor_category] ([category]) VALUES('Cardiologists')
INSERT INTO [doctor_category] ([category]) VALUES('Endocrinologists')
INSERT INTO [doctor_category] ([category]) VALUES('Gastroenterologists')
INSERT INTO [doctor_category] ([category]) VALUES('Nephrologists')
INSERT INTO [doctor_category] ([category]) VALUES('Urologists')
INSERT INTO [doctor_category] ([category]) VALUES('Pulmonologists')
INSERT INTO [doctor_category] ([category]) VALUES('Otolaryngologists (ENT)')
INSERT INTO [doctor_category] ([category]) VALUES('Neurologists')
INSERT INTO [doctor_category] ([category]) VALUES('Psychiatrists')
INSERT INTO [doctor_category] ([category]) VALUES('Oncologists')
INSERT INTO [doctor_category] ([category]) VALUES('Radiologists')
INSERT INTO [doctor_category] ([category]) VALUES('Rheumatologists')
INSERT INTO [doctor_category] ([category]) VALUES('Anesthesiologists')
INSERT INTO [doctor_category] ([category]) VALUES('Hematologist')
INSERT INTO [doctor_category] ([category]) VALUES('Immunologist ')
INSERT INTO [doctor_category] ([category]) VALUES('Somnologist')
INSERT INTO [doctor_category] ([category]) VALUES('Pediatrician')
INSERT INTO [doctor_category] ([category]) VALUES('General Surgeons')
INSERT INTO [doctor_category] ([category]) VALUES('Orthopedic Surgeons')
INSERT INTO [doctor_category] ([category]) VALUES('Cardiac Surgeons')

INSERT INTO [icd-11_doctor_recommendation] ([icd-11_id], [doctor_category_id]) VALUES(1, 4)
INSERT INTO [icd-11_doctor_recommendation] ([icd-11_id], [doctor_category_id]) VALUES(2, 16)
INSERT INTO [icd-11_doctor_recommendation] ([icd-11_id], [doctor_category_id]) VALUES(3, 20)
INSERT INTO [icd-11_doctor_recommendation] ([icd-11_id], [doctor_category_id]) VALUES(4, 21)
INSERT INTO [icd-11_doctor_recommendation] ([icd-11_id], [doctor_category_id]) VALUES(5, 8)
INSERT INTO [icd-11_doctor_recommendation] ([icd-11_id], [doctor_category_id]) VALUES(6, 14)
INSERT INTO [icd-11_doctor_recommendation] ([icd-11_id], [doctor_category_id]) VALUES(7, 22)
INSERT INTO [icd-11_doctor_recommendation] ([icd-11_id], [doctor_category_id]) VALUES(8, 14)
INSERT INTO [icd-11_doctor_recommendation] ([icd-11_id], [doctor_category_id]) VALUES(9, 5)
INSERT INTO [icd-11_doctor_recommendation] ([icd-11_id], [doctor_category_id]) VALUES(9, 14)
INSERT INTO [icd-11_doctor_recommendation] ([icd-11_id], [doctor_category_id]) VALUES(10, 13)
INSERT INTO [icd-11_doctor_recommendation] ([icd-11_id], [doctor_category_id]) VALUES(11, 7)
INSERT INTO [icd-11_doctor_recommendation] ([icd-11_id], [doctor_category_id]) VALUES(12, 12)
INSERT INTO [icd-11_doctor_recommendation] ([icd-11_id], [doctor_category_id]) VALUES(13, 9)
INSERT INTO [icd-11_doctor_recommendation] ([icd-11_id], [doctor_category_id]) VALUES(13, 10)
INSERT INTO [icd-11_doctor_recommendation] ([icd-11_id], [doctor_category_id]) VALUES(14, 3)
INSERT INTO [icd-11_doctor_recommendation] ([icd-11_id], [doctor_category_id]) VALUES(15, 18)
INSERT INTO [icd-11_doctor_recommendation] ([icd-11_id], [doctor_category_id]) VALUES(16, 11)
INSERT INTO [icd-11_doctor_recommendation] ([icd-11_id], [doctor_category_id]) VALUES(17, 6)
INSERT INTO [icd-11_doctor_recommendation] ([icd-11_id], [doctor_category_id]) VALUES(17, 11)
INSERT INTO [icd-11_doctor_recommendation] ([icd-11_id], [doctor_category_id]) VALUES(18, 6)
INSERT INTO [icd-11_doctor_recommendation] ([icd-11_id], [doctor_category_id]) VALUES(19, 6)
INSERT INTO [icd-11_doctor_recommendation] ([icd-11_id], [doctor_category_id]) VALUES(20, 23)
INSERT INTO [icd-11_doctor_recommendation] ([icd-11_id], [doctor_category_id]) VALUES(21, 1)
INSERT INTO [icd-11_doctor_recommendation] ([icd-11_id], [doctor_category_id]) VALUES(22, 1)
INSERT INTO [icd-11_doctor_recommendation] ([icd-11_id], [doctor_category_id]) VALUES(23, 1)

INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (10, 'Penrod Scedall', '331 708 1220', 'pscedall0@hatena.ne.jp', 'Ipoh', '04/07/1985', '3 Bunting Lane', 'Male', '507')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (14, 'Katharine Dami', '508 656 3109', 'kdami1@microsoft.com', 'Cikadu', '12/11/1971', '72987 Linden Trail', 'Female', '701')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (14, 'Neal Marcroft', '185 709 2515', 'nmarcroft2@ezinearticles.com', 'Yuandun', '02/05/1962', '520 Alpine Park', 'Male', '701')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (23, 'Duffy Deathridge', '763 938 6498', 'ddeathridge3@imdb.com', 'El Escanito', '04/13/1963', '754 Nobel Drive', 'Male', '907')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (24, 'Rafi Blumfield', '234 508 2064', 'rblumfield4@toplist.cz', 'Nowlamary', '05/19/1982', '3223 Morningstar Circle', 'Male', '1002')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (14, 'Yulma Piatek', '871 259 5026', 'ypiatek5@go.com', 'Balikpapan', '10/12/1978', '19 Commercial Trail', 'Male', '703')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (23, 'Franny Rossborough', '730 861 8899', 'frossborough6@abc.net.au', 'Kuala Terengganu', '08/08/1988', '5384 Grayhawk Trail', 'Male', '907')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (9, 'Thomas Yves', '287 247 5057', 'tyves7@arizona.edu', 'Matai', '03/08/1991', '2215 Meadow Ridge Terrace', 'Male', '505')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (20, 'Horatius Staines', '636 486 8407', 'hstaines8@cornell.edu', 'Pontianak', '08/07/1983', '9640 Starling Circle', 'Male', '901')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (25, 'Cal Stoffel', '912 293 0315', 'cstoffel9@psu.edu', 'Calvinia', '01/21/1970', '73162 Stang Plaza', 'Male', '1006')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (18, 'Hazel Ilyunin', '441 505 1044', 'hilyunina@fema.gov', 'Krajan Bejagung', '10/11/1982', '500 Ridgeway Lane', 'Male', '808')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (19, 'Tulley Mourton', '844 599 3466', 'tmourtonb@timesonline.co.uk', 'Solna', '09/10/1966', '19774 Almo Avenue', 'Male', '810')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (6, 'Forest Callacher', '837 484 4493', 'fcallacherc@businessinsider.com', 'Berlin', '04/15/1990', '870 Namekagon Alley', 'Male', '410')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (24, 'Vidovic McCoy', '698 323 3992', 'vmccoyd@berkeley.edu', 'Guidong Chengguanzhen', '07/11/1976', '0239 Schmedeman Court', 'Male', '1002')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (16, 'Robb Van Hove', '633 679 2026', 'rvanf@nature.com', 'Jayapura', '04/11/1965', '47 Sycamore Crossing', 'Male', '802')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (1, 'Erhard Casburn', '688 654 4246', 'ecasburng@abc.net.au', 'La Paz', '05/11/1964', '433 Banding Road', 'Male', '301')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (1, 'Sansone Sidon', '935 862 1463', 'ssidonh@wunderground.com', 'Rongxi', '03/31/1974', '5091 Roth Way', 'Male', '303')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (11, 'Jarvis Zelake', '601 115 9314', 'jzelakej@cloudflare.com', 'Sishui', '05/02/1979', '0 Graedel Place', 'Male', '509')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (19, 'Ginny Cresar', '560 937 8961', 'gcresarl@photobucket.com', 'Flores', '03/29/1981', '47 Waxwing Crossing', 'Female', '810')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (13, 'Cassandre McCrie', '847 262 9394', 'cmccriem@economist.com', 'Qiaonan', '04/26/1986', '80351 Scofield Street', 'Female', '606')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (16, 'Gisela Warfield', '674 324 2471', 'gwarfieldo@fotki.com', 'Pongkor', '01/21/1980', '62 Bashford Park', 'Female', '802')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (20, 'Rickert Million', '226 654 7574', 'rmillionp@instagram.com', 'Medan', '06/22/1968', '088 Jay Plaza', 'Male', '901')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (12, 'Elvyn Jordine', '830 254 1311', 'ejordineq@google.de', 'Xishui', '09/03/1971', '4642 Bowman Place', 'Male', '602')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (3, 'Desiree Shevill', '256 418 9655', 'dshevills@taobao.com', 'Songhe', '06/10/1965', '5397 Barby Court', 'Female', '402')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (3, 'Sherline Dowrey', '884 265 8786', 'sdowreyt@booking.com', 'Svrljig', '12/11/1964', '37 Vera Junction', 'Female', '402')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (21, 'Lanny Jakeman', '919 222 8855', 'ljakemanu@homestead.com', 'Razvanje', '01/28/1983', '16780 Sherman Center', 'Male', '903')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (1, 'Lettie Cleveley', '691 551 6105', 'lcleveleyv@state.tx.us', 'Lexington', '11/23/1971', '1250 Leroy Junction', 'Female', '305')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (26, 'Mariann Lippiello', '153 727 2391', 'mlippielloy@symantec.com', 'Aygepat', '10/06/1968', '8466 Eastlawn Parkway', 'Female', '1008')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (1, 'Muriel Rangle', '226 137 5388', 'mranglez@plala.or.jp', 'Shardara', '10/14/1967', '68105 John Wall Trail', 'Female', '301')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (3, 'Roy Ganley', '579 150 8125', 'rganley10@squidoo.com', 'Krajan', '10/18/1989', '6602 Debs Plaza', 'Male', '404')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (16, 'Brennan McArd', '215 168 4110', 'bmcard11@over-blog.com', 'Siliana', '02/11/1964', '2765 Homewood Terrace', 'Male', '804')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (26, 'Dee Keddey', '523 528 1296', 'dkeddey12@desdev.cn', 'Dashtavan', '12/14/1982', '7 Eggendart Street', 'Female', '1008')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (12, 'Zedekiah Sirr', '317 792 0429', 'zsirr13@bloglines.com', 'Dvurechensk', '02/22/1965', '36815 Oneill Plaza', 'Male', '602')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (3, 'Shelton Camier', '455 758 9542', 'scamier14@yolasite.com', 'Mosty', '09/23/1963', '6690 Hooker Drive', 'Male', '404')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (13, 'Benji Haycraft', '252 590 9366', 'bhaycraft18@auda.org.au', 'Wairiang', '02/11/1972', '3 Bunting Parkway', 'Male', '606')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (12, 'Doe Croson', '452 348 6611', 'dcroson1a@gov.uk', 'Xiangang', '01/12/1972', '6 Jackson Street', 'Female', '604')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (22, 'Weidar Nuss', '608 107 7295', 'wnuss1b@ucoz.com', 'Huayana', '01/06/1972', '076 Atwood Park', 'Male', '905')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (5, 'Natalina Peizer', '767 633 6210', 'npeizer1c@phoca.cz', 'Padang', '06/11/1978', '74 Merchant Drive', 'Female', '408')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (14, 'Schuyler DelaField', '425 251 9597', 'sdelafield1e@icq.com', 'Chaem Luang', '03/19/1978', '255 Buell Plaza', 'Male', '703')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (6, 'Erin Totaro', '907 745 6653', 'etotaro1f@bandcamp.com', 'Hedong', '07/06/1971', '90823 Gulseth Plaza', 'Female', '410')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (23, 'Annmarie Bover', '497 167 4051', 'abover1h@reverbnation.com', 'Schiltigheim', '03/25/1990', '25218 Sunfield Trail', 'Female', '909')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (25, 'Archy Bosket', '165 260 4270', 'abosket1j@hibu.com', 'Besah', '07/16/1968', '75 Cambridge Drive', 'Male', '1006')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (24, 'Oswald Janauschek', '885 155 7063', 'ojanauschek1n@cdbaby.com', 'Denpasar', '06/21/1981', '622 Merrick Hill', 'Male', '1004')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (17, 'Charmaine Ralph', '429 398 8162', 'cralph1p@people.com.cn', 'Boyle', '03/27/1988', '620 Golf Course Street', 'Female', '806')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (17, 'Daisy Allanby', '835 464 8793', 'dallanby1q@networkadvertising.org', 'Obando', '09/07/1972', '83 Farragut Avenue', 'Female', '806')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (2, 'Conrado Doughtery', '257 524 0200', 'cdoughtery1s@army.mil', 'Bowen Island', '12/30/1980', '82 Paget Drive', 'Male', '307')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (13, 'Allina Cavill', '564 768 2704', 'acavill1t@nih.gov', 'Aurora', '12/09/1988', '538 Dwight Hill', 'Female', '608')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (1, 'Marne Vanished', '918 307 3396', 'mconn1v@umich.edu', 'Bandung', '05/28/1968', '734 Memorial Alley', 'Female', '303')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (11, 'Iris Donavan', '776 256 9019', 'idonavan1w@stumbleupon.com', 'Hongwansi', '01/26/1972', '6378 Dawn Circle', 'Female', '509')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (4, 'Ossie Stiegar', '500 802 2891', 'ostiegar1x@plala.or.jp', 'Jorge', '02/20/1976', '57706 Summit Pass', 'Male', '406')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (15, 'Egon Point', '645 933 1731', 'epoint1y@businesswire.com', 'Jendouba', '08/26/1989', '0 Oxford Hill', 'Male', '705')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (15, 'Saunderson Millier', '607 991 1272', 'smillier20@mapy.cz', 'Orahovac', '03/28/1991', '07 Norway Maple Road', 'Male', '705')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (7, 'Anna-maria Hallowes', '516 628 1761', 'ahallowes22@opensource.org', 'Sanfang', '02/15/1964', '432 Crest Line Circle', 'Female', '501')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (22, 'Flory Hallibone', '706 641 8739', 'fhallibone23@tamu.edu', 'Ithari', '02/13/1962', '0707 4th Crossing', 'Male', '905')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (16, 'De Copperwaite', '869 196 2039', 'dcopperwaite24@godaddy.com', 'Palu', '08/23/1991', '0 Fremont Trail', 'Female', '804')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (7, 'Leroi Maccree', '611 169 2438', 'lmaccree25@hp.com', 'Bambari', '03/23/1989', '48156 Bartelt Place', 'Male', '501')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (1, 'Katine Fancett', '164 733 0855', 'kfancett27@webnode.com', 'Sekararum', '11/14/1981', '34954 Tomscot Hill', 'Female', '305')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (8, 'Ellerey Stearndale', '701 497 6725', 'estearndale2a@wunderground.com', 'Jawornik', '10/22/1969', '6 Stoughton Center', 'Male', '503')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (23, 'Baxter Dmitrienko', '934 794 6005', 'bdmitrienko2b@desdev.cn', 'Belogorsk', '10/10/1971', '600 Basil Point', 'Male', '909')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (13, 'Jacinthe Dugood', '439 948 1598', 'jdugood2e@list-manage.com', 'Slavyanovo', '05/11/1966', '234 Duke Circle', 'Female', '608')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (4, 'Otha Duerden', '968 180 8443', 'oduerden2h@reddit.com', 'Jiazhuang', '05/17/1985', '42747 Kenwood Drive', 'Female', '406')
INSERT INTO [doctor] ([doctor_category_id], [name],phone_number, [email], city_of_birth, date_of_birth, address, gender, assigned_room) VALUES (5, 'Carmelia Lacroux', '563 100 3656', 'clacroux2i@vk.com', 'Damasak', '03/30/1979', '57 Tomscot Point', 'Female', '408')

INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Lucienne Firidolfi', '210 388 4699', 'lfiridolfi0@artisteer.com', 'Tres Isletas', '11/09/1990', '59 Gateway Way', 'Female', 'AB-', '08/13/2009')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Albrecht Gowdie', '929 371 5286', 'agowdie1@google.co.uk', 'Alaverdi', '07/21/1984', '9 Talmadge Court', 'Male', 'O-', '12/04/2001')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Rubin Bigley', '977 926 5141', 'rbigley2@telegraph.co.uk', 'Bloomington', '05/17/1991', '1806 Hoffman Parkway', 'Male', 'AB+', '07/31/2012')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Chaunce Eggleton', '948 596 1053', 'ceggleton3@acquirethisname.com', 'La Loma', '03/18/1968', '16237 Dawn Park', 'Male', 'O+', '03/22/2009')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Harriette Doogan', '605 927 2558', 'hdoogan4@blog.com', 'Palu', '07/21/1980', '571 Mallard Pass', 'Female', 'B-', '02/18/2021')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Winifred McKeag', '836 331 2231', 'wmckeag5@cnet.com', 'Santai', '02/04/1970', '8 Farwell Plaza', 'Female', 'A+', '04/15/2010')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Donnell Attridge', '196 829 2219', 'dattridge6@walmart.com', 'Wakuya', '01/29/1988', '63 Comanche Avenue', 'Male', 'A-', '05/22/2020')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Gaile Ruffli', '643 312 1885', 'gruffli7@w3.org', 'Aceh', '03/20/1975', '4 American Alley', 'Male', 'O-', '01/14/2005')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Rustie Sickamore', '423 170 1015', 'rsickamore8@tuttocitta.it', 'Karolino-Buhaz', '07/08/1990', '985 Monument Terrace', 'Male', 'O-', '05/11/2002')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Artemas Kinson', '324 753 6088', 'akinson9@mashable.com', 'Nguluhan', '09/07/1989', '704 Gateway Plaza', 'Male', 'AB+', '12/15/2019')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Caitrin Ronald', '841 353 8666', 'cronalda@tumblr.com', 'Raemude', '02/23/1964', '73 Nobel Junction', 'Female', 'B+', '10/07/2005')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Moore Fuzzard', '371 360 7974', 'mfuzzardb@123-reg.co.uk', 'Gazli', '07/09/1974', '251 Dwight Parkway', 'Male', 'A-', '08/10/2020')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Lorita Gumey', '211 649 2182', 'lgumeyc@soundcloud.com', 'Pulian', '03/28/1991', '6740 Schiller Pass', 'Female', 'B+', '09/08/2015')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Mag Dirand', '561 323 8956', 'mdirandd@cdc.gov', 'Carvalhais', '06/25/1964', '80208 Granby Crossing', 'Female', 'B-', '09/11/2016')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Vivi Devonish', '830 386 7829', 'vdevonishe@github.io', 'Balayong', '01/06/1981', '63747 Tony Crossing', 'Female', 'B-', '02/06/2012')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Hesther Kanter', '906 609 3804', 'hkanterf@google.nl', 'Chengnan', '08/15/1975', '6231 Little Fleur Road', 'Female', 'A+', '08/28/2014')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Benjamen Carillo', '681 579 2588', 'bcarillog@ocn.ne.jp', 'Beira', '04/15/1964', '2690 Tomscot Center', 'Male', 'A-', '03/19/2007')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Gordon Ortsmann', '401 478 4710', 'gortsmannh@freewebs.com', 'Knyazhichi', '01/31/1965', '7097 Jenifer Center', 'Male', 'A-', '11/07/2015')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Felicle Maliphant', '544 120 6822', 'fmaliphanti@who.int', 'Rizal', '10/03/1980', '283 Arapahoe Circle', 'Female', 'A-', '09/03/2008')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Salomone Arondel', '246 185 4167', 'sarondelj@mysql.com', 'Sukaraja', '07/25/1983', '893 Oakridge Court', 'Male', 'A-', '04/23/2018')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Killian Lincoln', '157 581 3407', 'klincolnk@irs.gov', 'Tigpalay', '07/16/1979', '894 Manley Street', 'Male', 'O+', '01/03/2001')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Hesther Dougary', '512 530 8849', 'hdougaryl@scribd.com', 'Kupang', '10/22/1962', '2754 Granby Alley', 'Female', 'O-', '11/24/2020')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Efrem Attrill', '659 427 1223', 'eattrillm@gov.uk', 'Alae', '05/29/1962', '992 Cordelia Alley', 'Male', 'O-', '08/01/2019')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Jessica Bockings', '730 258 6391', 'jbockingsn@microsoft.com', 'Rancharia', '12/20/1983', '4920 Dahle Pass', 'Female', 'AB-', '07/13/2016')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Eliot Gosneye', '670 876 0243', 'egosneyeo@cpanel.net', 'Zhouzhuang', '02/15/1982', '052 Chinook Parkway', 'Male', 'O+', '01/14/2020')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Latrena Broomfield', '871 208 0531', 'lbroomfieldp@soup.io', 'Moppo', '08/02/1978', '132 Independence Trail', 'Female', 'A+', '05/07/2015')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Maxy Sinson', '311 325 3878', 'msinsonq@t.co', 'Bandung', '05/10/1972', '57 Mallard Crossing', 'Male', 'AB+', '11/06/2020')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Silvain Leydon', '633 950 3672', 'sleydonr@pinterest.com', 'Hengshi', '04/30/1987', '414 Loeprich Alley', 'Male', 'O+', '04/23/2011')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Aimee Kilmartin', '316 131 8593', 'akilmartins@twitter.com', 'San Juan', '12/16/1971', '345 Dawn Crossing', 'Female', 'A+', '02/26/2009')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Ilyse Durant', '546 977 4151', 'idurantt@dyndns.org', 'Helmsange', '06/29/1963', '5307 Roxbury Road', 'Female', 'A+', '07/06/2010')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Brett Allsep', '190 677 2063', 'ballsepu@technorati.com', 'Salaya', '12/09/1981', '792 Ryan Parkway', 'Male', 'A-', '04/06/2009')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Mufi Chorlton', '123 129 8824', 'mchorltonv@woothemes.com', 'Bogor', '11/04/1988', '64 Sutteridge Center', 'Female', 'AB-', '11/12/2013')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Sullivan Dufore', '745 106 6090', 'sduforew@google.co.jp', 'Chifeng', '04/16/1982', '9 Pearson Road', 'Male', 'A+', '01/07/2003')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Kelly Deboy', '199 153 5089', 'kdeboyx@wsj.com', 'Kolyubakino', '04/27/1985', '99748 Haas Park', 'Male', 'O-', '11/12/2012')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Morrie Ginger', '654 677 8000', 'mgingery@feedburner.com', 'Jakarta', '03/01/1968', '7195 Blaine Center', 'Male', 'AB-', '07/28/2017')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Jenica Atwater', '516 890 4669', 'jatwaterz@ask.com', 'Phu Sang', '07/16/1974', '759 Kropf Park', 'Female', 'B+', '02/16/2018')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Huntley Tremmel', '565 621 1439', 'htremmel10@theglobeandmail.com', 'Xunzhai', '01/31/1975', '12619 Dakota Alley', 'Male', 'O-', '09/28/2006')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Vanda Le Batteur', '461 387 5616', 'vle11@usnews.com', 'Vadstena', '05/13/1970', '431 Ohio Street', 'Female', 'AB-', '08/30/2015')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Munroe Dandy', '421 823 2030', 'mdandy12@example.com', 'Yandun', '05/31/1963', '9880 Burrows Point', 'Male', 'A-', '10/30/2010')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Erv O''Currigan', '465 441 3593', 'eocurrigan13@dyndns.org', 'Casais de Vera Cruz', '08/29/1989', '169 Clove Parkway', 'Male', 'A+', '04/18/2019')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Shayne Delamar', '823 234 9770', 'sdelamar14@google.fr', 'Tataouine', '05/23/1976', '572 Village Junction', 'Female', 'B-', '07/30/2004')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Malissia Ostridge', '140 469 7681', 'mostridge15@joomla.org', 'La Esperanza', '01/01/1974', '29502 Alpine Court', 'Female', 'A+', '09/19/2001')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Oralle Wickersley', '853 618 5288', 'owickersley16@forbes.com', 'Huaishu', '03/16/1966', '051 Lyons Point', 'Female', 'B+', '02/08/2002')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Emilio Moffat', '684 796 8509', 'emoffat17@va.gov', 'Roseau', '06/21/1990', '821 Acker Center', 'Male', 'AB+', '02/20/2000')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Clementina Lages', '412 905 1482', 'clages18@posterous.com', 'Koktokay', '10/25/1988', '242 Hanson Alley', 'Female', 'O+', '07/23/2000')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Gillan Sutterby', '607 955 6222', 'gsutterby19@mlb.com', 'Duanjia', '08/27/1981', '27351 Scoville Parkway', 'Female', 'AB-', '09/26/2009')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Dasya Cromarty', '729 572 5230', 'dcromarty1a@e-recht24.de', 'Tapan', '11/26/1975', '778 Lunder Park', 'Female', 'O-', '12/24/2011')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Brook Kivits', '874 301 1735', 'bkivits1b@meetup.com', 'Gora', '01/06/1974', '01 Basil Avenue', 'Female', 'AB+', '10/17/2005')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Leontyne Hakey', '126 736 5699', 'lhakey1c@zdnet.com', 'Knoxville', '01/26/1979', '340 Elmside Street', 'Female', 'O+', '10/10/2003')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Carmela Morphet', '971 334 8641', 'cmorphet1d@tiny.cc', 'Muyuzi', '05/09/1962', '539 Texas Place', 'Female', 'AB+', '07/12/2004')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Dorree Halso', '931 386 1941', 'dhalso1e@trellian.com', 'Bali', '06/05/1991', '02 Steensland Terrace', 'Female', 'AB-', '01/01/2021')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Emilio Robbert', '532 224 1064', 'erobbert1f@examiner.com', 'Bakuriani', '01/18/1972', '028 Darwin Place', 'Male', 'AB+', '04/04/2022')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Kasey Maylour', '665 369 6014', 'kmaylour1g@goo.gl', 'Qingtong', '09/09/1983', '559 Briar Crest Trail', 'Female', 'AB-', '10/03/2011')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Abbie Marages', '881 355 9077', 'amarages1h@dropbox.com', 'Petaling Jaya', '12/30/1982', '9 Center Road', 'Female', 'AB-', '12/17/2016')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Daron Halvorsen', '178 381 9280', 'dhalvorsen1i@smugmug.com', 'El Cerrito', '02/22/1986', '43817 Jay Point', 'Female', 'O-', '03/01/2017')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Terry Soanes', '167 477 7645', 'tsoanes1j@ovh.net', 'Brebes', '06/07/1964', '9305 Veith Lane', 'Female', 'B-', '09/09/2002')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Kathryn Chrichton', '337 349 6688', 'kchrichton1k@alexa.com', 'Makasar', '07/21/1984', '80918 Melvin Circle', 'Female', 'AB-', '11/25/2005')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Meridel Crannage', '968 153 0001', 'mcrannage1l@xinhuanet.com', 'Jayapura', '04/19/1991', '76309 Annamark Trail', 'Female', 'AB-', '08/11/2009')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Deborah Ainsby', '635 338 5124', 'dainsby1m@discuz.net', 'Naranjos', '07/03/1990', '5635 Sutteridge Center', 'Female', 'O-', '12/19/2020')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Boone Rickett', '399 665 8507', 'brickett1n@quantcast.com', 'Dunaivtsi', '09/30/1964', '777 New Castle Lane', 'Male', 'AB-', '12/16/2009')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Kennett Wadhams', '934 565 4607', 'kwadhams1o@time.com', 'Rembang', '09/02/1988', '3759 Lerdahl Terrace', 'Male', 'A-', '03/16/2017')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Sayres Raphael', '818 576 5452', 'sraphael1p@cornell.edu', 'Zhongcheng', '08/24/1992', '0638 Dunning Junction', 'Male', 'B+', '01/10/2001')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Bastian Gueinn', '430 327 4268', 'bgueinn1q@ebay.co.uk', 'Tiztoutine', '08/16/1984', '76327 Cordelia Junction', 'Male', 'A-', '12/23/2011')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Helsa Marke', '684 427 7174', 'hmarke1r@free.fr', 'Ternate', '01/19/1975', '72 Veith Hill', 'Female', 'O-', '08/14/2006')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Griffy Kornyakov', '856 420 5002', 'gkornyakov1s@nymag.com', 'Venustiano Carranza', '03/13/1963', '738 Susan Hill', 'Male', 'O-', '09/02/2008')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Isaiah Fitzer', '106 638 5566', 'ifitzer1t@netvibes.com', 'Jingjiang', '06/13/1982', '1 Moose Parkway', 'Male', 'A+', '04/21/2018')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Penelope Delle', '725 118 9580', 'pdelle1u@blinklist.com', 'Wenshui', '08/23/1983', '10 Hovde Pass', 'Female', 'A+', '12/06/2006')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Orsa Eschalette', '521 769 7684', 'oeschalette1v@nymag.com', 'Jakarta', '11/17/1974', '7306 Hovde Alley', 'Female', 'B+', '11/22/2009')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Lorain Capoun', '493 519 2670', 'lcapoun1w@topsy.com', 'Nyaungdon', '08/25/1968', '24700 Hermina Plaza', 'Female', 'A+', '07/27/2018')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Kriste Bidder', '487 192 1040', 'kbidder1x@reddit.com', 'Pickering', '06/03/1983', '0343 Lunder Junction', 'Female', 'AB-', '09/11/2003')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Francyne Ivey', '469 315 1497', 'fivey1y@xing.com', 'Detroit', '01/04/1964', '8 Declaration Park', 'Female', 'B+', '09/16/2014')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Charmian Copland', '302 310 5154', 'ccopland1z@gov.uk', 'Pinhais', '05/13/1986', '635 Dexter Lane', 'Female', 'A+', '08/25/2005')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Johannes Quartley', '929 424 3832', 'jquartley20@themeforest.net', 'Kiarajangkung', '01/05/1979', '29 Grover Place', 'Male', 'A+', '03/17/2001')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Karleen Glyne', '182 826 2540', 'kglyne21@yolasite.com', 'Cibunar', '02/01/1971', '9894 Morning Road', 'Female', 'A+', '04/30/2006')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Gretna Flescher', '124 919 9746', 'gflescher22@godaddy.com', 'Nyinqug', '11/18/1972', '1062 Carberry Junction', 'Female', 'B+', '03/02/2004')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Perry Hadgkiss', '997 812 4880', 'phadgkiss23@illinois.edu', 'Nobeoka', '06/06/1966', '0666 Aberg Pass', 'Female', 'O-', '12/07/2006')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Corny Cossington', '531 507 0042', 'ccossington24@facebook.com', 'Surabaya', '11/26/1983', '158 Hudson Terrace', 'Female', 'O+', '03/14/2008')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Tyson Carl', '929 152 5000', 'tcarl25@guardian.co.uk', 'El Espino', '09/10/1965', '4 Basil Park', 'Male', 'AB+', '07/27/2004')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Alessandra Halligan', '842 279 6629', 'ahalligan26@yellowpages.com', 'Pimbalayan', '02/06/1978', '02 Stang Hill', 'Female', 'A+', '01/08/2018')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Cammy Pittam', '219 270 8809', 'cpittam27@ycombinator.com', 'Sijunjung', '09/28/1971', '7477 East Drive', 'Male', 'O-', '09/09/2011')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Annabela Towlson', '604 706 9315', 'atowlson28@ft.com', 'Muarabadak', '06/03/1985', '05 Melrose Parkway', 'Female', 'B+', '02/18/2019')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Luce Linford', '662 728 3017', 'llinford29@epa.gov', 'Padang', '09/12/1977', '3186 Sycamore Alley', 'Male', 'O+', '05/02/2018')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Rodd Tortoise', '289 955 4994', 'rtortoise2a@aol.com', 'Medan', '11/02/1974', '34742 Evergreen Place', 'Male', 'O+', '10/08/2020')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Cristobal Lynds', '650 438 6078', 'clynds2b@csmonitor.com', 'Huji', '07/01/1982', '081 Westend Center', 'Male', 'O-', '11/25/2007')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Trey Barkly', '245 305 8014', 'tbarkly2c@jalbum.net', 'Manado', '04/24/1977', '05349 Arapahoe Road', 'Male', 'AB-', '11/05/2019')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Olimpia Ayliffe', '393 964 7108', 'oayliffe2d@webs.com', 'Krasnodon', '06/24/1962', '04256 Eagan Plaza', 'Female', 'B-', '03/26/2022')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Cobby Fursland', '581 625 8310', 'cfursland2e@admin.ch', 'Pontianak', '03/26/1974', '8 Park Meadow Center', 'Male', 'O-', '06/08/2011')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Pansy Bessett', '228 222 9084', 'pbessett2f@ihg.com', 'Tejakalapa', '08/07/1973', '971 Straubel Crossing', 'Female', 'AB+', '11/01/2017')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Lydie Burndred', '969 289 8747', 'lburndred2g@domainmarket.com', 'Pimentel', '09/17/1978', '5403 Stoughton Park', 'Female', 'B+', '11/29/2018')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Erma Saffle', '285 961 0125', 'esaffle2h@blog.com', 'Yacheng', '07/30/1989', '8667 Mcbride Drive', 'Female', 'AB-', '01/24/2009')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Daron Seamen', '200 993 4386', 'dseamen2i@salon.com', 'Semarang', '04/29/1983', '8466 Longview Drive', 'Female', 'O+', '10/02/2019')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Bellanca Rochelle', '700 123 7539', 'brochelle2j@godaddy.com', 'Sicaya', '05/09/1992', '72 Burning Wood Hill', 'Female', 'O+', '05/13/2008')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Vanny Torra', '119 542 8123', 'vtorra2k@ca.gov', 'Peddie', '05/15/1986', '5 Mayer Parkway', 'Female', 'AB+', '05/12/2016')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Jerrold Vanished', '398 642 6607', 'jmounter2l@marketwatch.com', 'Yancheng', '06/09/1966', '7 Everett Hill', 'Male', 'O+', '07/26/2014')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Dorisa Dysert', '830 800 4679', 'ddysert2m@pinterest.com', 'Dayou', '06/27/1976', '4 Roxbury Point', 'Female', 'O+', '05/08/2001')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Olvan Danilewicz', '511 338 8726', 'odanilewicz2n@parallels.com', 'Urechcha', '02/18/1984', '9377 Iowa Street', 'Male', 'B-', '01/06/2012')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Gennie Oppery', '380 305 6720', 'goppery2o@who.int', 'Baga Borihe', '01/20/1981', '2407 Fisk Drive', 'Female', 'AB+', '11/10/2021')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Hilliard Grassot', '605 511 4835', 'hgrassot2p@360.cn', 'Salcedo', '02/13/1982', '19907 Tomscot Road', 'Male', 'AB+', '06/29/2013')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Gasparo Bontoft', '266 963 0184', 'gbontoft2q@europa.eu', 'Huddinge', '07/01/1982', '982 Luster Parkway', 'Male', 'O+', '01/24/2012')
INSERT INTO [patient] ([name], phone_number, [email], city_of_birth, date_of_birth, address, gender, blood_type, created_at) VALUES ('Gaby Roark', '325 236 9516', 'groark2r@sphinn.com', 'Jakarta', '04/24/1977', '48950 Saint Paul Circle', 'Male', 'AB+', '06/28/2017')

INSERT INTO [meeting] ([patient_id], [doctor_id], room, [date], queue_number) VALUES (6, 16, 301, '09/09/2022', 1)
INSERT INTO [meeting] ([patient_id], [doctor_id], room, [date], queue_number) VALUES (17, 30, 305, '09/09/2022', 1)
INSERT INTO [meeting] ([patient_id], [doctor_id], room, [date], queue_number) VALUES (21, 16, 301, '09/09/2022', 2)
INSERT INTO [meeting] ([patient_id], [doctor_id], room, [date], queue_number) VALUES (6, 16, 301, '09/11/2022', 1)
INSERT INTO [meeting] ([patient_id], [doctor_id], room, [date], queue_number) VALUES (6, 46, 307, '09/13/2022', 1)
INSERT INTO [meeting] ([patient_id], [doctor_id], room, [date], queue_number) VALUES (2, 2, 305, '09/13/2022', 1)
INSERT INTO [meeting] ([patient_id], [doctor_id], room, [date], queue_number) VALUES (44, 16, 301, '09/13/2022', 2)
INSERT INTO [meeting] ([patient_id], [doctor_id], room, [date], queue_number) VALUES (8, 16, 301, '09/13/2022', 3)
INSERT INTO [meeting] ([patient_id], [doctor_id], room, [date], queue_number) VALUES (23, 20, 608, '09/14/2022', 1)
INSERT INTO [meeting] ([patient_id], [doctor_id], room, [date], queue_number) VALUES (69, 20, 608, '09/14/2022', 2)
INSERT INTO [meeting] ([patient_id], [doctor_id], room, [date], queue_number) VALUES (88, 20, 608, '09/14/2022', 3)

INSERT INTO [patient_record] ([patient_id], [meeting_id], notes, date) VALUES (6, 1, 'Initial suspicion of mild flu. Need further lab test to check.', '09/09/2022')
INSERT INTO [patient_record] ([patient_id], [meeting_id], notes, date) VALUES (6, 1, 'Prescribed with cold medicine and patient needs to take bed rest for 1-2 days.', '09/09/2022')
INSERT INTO [patient_record] ([patient_id], [meeting_id], notes, date) VALUES (6, 1, 'Come back after blood test result available.', '09/09/2022')
INSERT INTO [patient_record] ([patient_id], [meeting_id], notes, date) VALUES (17, 2, 'Tinea Corporis: A scaly ring-shaped area, circular rash with clearer skin on left arm, possibly spreading. Itchiness. Slightly raised, expanding rings. ', '09/09/2022')
INSERT INTO [patient_record] ([patient_id], [meeting_id], notes, date) VALUES (17, 2, 'Prescribed with antifungal pills for 5 weeks. Consult back after the pill finished.', '09/09/2022')
INSERT INTO [patient_record] ([patient_id], [meeting_id], notes, date) VALUES (21, 3, 'A tickling sensation in the throat leads to dry cough. No mocus produced. Early mild indication of pharyngitis.', '09/10/2022')
INSERT INTO [patient_record] ([patient_id], [meeting_id], notes, date) VALUES (21, 3, 'Fever, swollen lymph nodes in the neck, headache and earache.', '09/10/2022')
INSERT INTO [patient_record] ([patient_id], [meeting_id], notes, date) VALUES (21, 3, 'Most likely bacterial infections. Prescribed with antibiotics. ', '09/10/2022')
INSERT INTO [patient_record] ([patient_id], [meeting_id], notes, date) VALUES (6, 4, 'Lab result indicates that patient had Allergic Rhinitis. Need further consultation to Allergists.', '09/11/2022')

INSERT INTO [payment] ([meeting_id], card_holder_name, primary_account_number, expiration_date, service_code, total_payment, created_at) VALUES(2, 'Benjamen Carillo', '4017957642681560', '02/05/2027', 178, 979208, '09/09/2022 13:28:31')
INSERT INTO [payment] ([meeting_id], card_holder_name, primary_account_number, expiration_date, service_code, total_payment, created_at) VALUES(1, 'Winifred McKeag', '4017956650188610', '11/28/2026', 224, 428950, '09/09/2022 13:37:53')
INSERT INTO [payment] ([meeting_id], card_holder_name, primary_account_number, expiration_date, service_code, total_payment, created_at) VALUES(3, 'Maureene Sogg', '4287306683417502', '11/11/2025', 904, 1339745, '09/09/2022 14:00:11')
INSERT INTO [payment] ([meeting_id], card_holder_name, primary_account_number, expiration_date, service_code, total_payment, created_at) VALUES(4, 'Winifred McKeag', '4017956650188610', '11/28/2026', 224, 1531000, '09/11/2022 11:01:44')

INSERT INTO [payment_detail] ([payment_id], item, nominal, notes, created_at) VALUES (1, 'Dermatologists consultation', 385000, '-', '09/09/2022 13:28:31')
INSERT INTO [payment_detail] ([payment_id], item, nominal, notes, created_at) VALUES (1, 'On site prescription', 124685, '-', '09/09/2022 13:28:32')
INSERT INTO [payment_detail] ([payment_id], item, nominal, notes, created_at) VALUES (1, 'Take home prescription', 469523, '-', '09/09/2022 13:28:32')
INSERT INTO [payment_detail] ([payment_id], item, nominal, notes, created_at) VALUES (2, 'General Practicioner consultation', 150000, '-', '09/09/2022 13:37:53')
INSERT INTO [payment_detail] ([payment_id], item, nominal, notes, created_at) VALUES (2, 'Take home prescription', 278950, '-', '09/09/2022 13:37:53')
INSERT INTO [payment_detail] ([payment_id], item, nominal, notes, created_at) VALUES (3, 'General Practicioner consultation', 150000, '-', '09/09/2022 14:00:11')
INSERT INTO [payment_detail] ([payment_id], item, nominal, notes, created_at) VALUES (3, 'Additional medical instruments', 200000, '-', '09/09/2022 14:00:12')
INSERT INTO [payment_detail] ([payment_id], item, nominal, notes, created_at) VALUES (3, 'On site medical treatment', 300000, '-', '09/09/2022 14:00:11')
INSERT INTO [payment_detail] ([payment_id], item, nominal, notes, created_at) VALUES (3, 'Take home prescription', 689745, '-', '09/09/2022 14:00:12')
INSERT INTO [payment_detail] ([payment_id], item, nominal, notes, created_at) VALUES (4, 'General Practicioner consultation', 175000, '-', '09/11/2022 11:01:45')
INSERT INTO [payment_detail] ([payment_id], item, nominal, notes, created_at) VALUES (4, 'Take home prescription', 1356000, '-', '09/11/2022 11:01:46')