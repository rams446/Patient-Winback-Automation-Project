# Patient-Winback-Automation-Project
Goal : This project automates a "Win-Back" campaign to send them New Treatment Info and Special Offers.

The Data Architecture (The Setup)
I designed this using two specific tables in Salesforce Marketing Cloud:
    Patients_Master: (SubscriberKey, FirstName, Email, PreferredTreatment)
    _Open Data View: (System table that tracks every email open)
    
The Technical Logic (SQL)
This query identifies patients who have not opened an email in the last 90 days. I use a LEFT JOIN to find the "holes" in the data.
SELECT 
    p.PatientID, 
    p.EmailAddress, 
    p.FirstName, 
    p.PreferredTreatment
FROM [Patients_Master] AS p
LEFT JOIN [_Open] AS o 
    ON p.PatientID = o.SubscriberKey 
    AND o.EventDate > DATEADD(day, -90, GETDATE())
WHERE o.EventDate IS NULL

The Creative Personalization (HTML/AMPscript)
To make the email "high-conversion," I used AMPscript to change the offer based on the patient's history.
  %%
  [VAR @Offer 
  IF PreferredTreatment == "Dental" THEN SET @Offer = "10% off your next Cleaning" 
  ELSEIF PreferredTreatment == "Vision" THEN SET @Offer = "Free Frame Upgrade" 
  ELSE SET @Offer = "Free Health Consultation" 
  ENDIF 
]%%

<h1>Hello %%FirstName%%, we miss you!</h1>
<p>Because we care about your health, we have a special offer for you:</p>
<h2>%%=v(@Offer)=%%</h2>
<a href="https://clinic.org/renew">Claim My Offer</a>

Automation Studio

I configured this to run automatically in Automation Studio so no manual work is required:
Step 1 (SQL Activity): Runs the query above to find the "Lapsed" patients.
Step 2 (Wait): Adds a 1-hour buffer for data processing.
Step 3 (Email Send): Deploys the personalized "Win-Back" template.
Step 4 (Verification): A safety check that stops the send if the list size looks suspiciously large (protects sender reputation).

Results & "Production Support" Mindset
Success Metric: Aimed for a 15% re-activation rate.

QA Step: I performed "A/B Testing" on the subject lines to see if "New Treatments" or "Special Offers" performed better.
