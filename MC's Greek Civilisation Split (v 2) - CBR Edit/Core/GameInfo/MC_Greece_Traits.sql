CREATE TABLE IF NOT EXISTS 
	Civilization_FreePolicies (
	CivilizationType  		text 		REFERENCES Civilizations(Type) 		default null,
	PolicyType				text 		REFERENCES Policies(Type) 			default null);