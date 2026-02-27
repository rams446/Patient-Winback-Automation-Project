/* Target: Patients inactive for 90 days
Logic: Left Join Patients to Open Data View 
*/

SELECT 
    p.PatientID, 
    p.EmailAddress, 
    p.FirstName, 
    p.Preferred_Treatment_Type
FROM [Patients_Master] AS p
LEFT JOIN [_Open] AS o 
    ON p.PatientID = o.SubscriberKey 
    AND o.EventDate > DATEADD(day, -90, GETDATE())
WHERE o.EventDate IS NULL
