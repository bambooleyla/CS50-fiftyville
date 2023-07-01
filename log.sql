-- Find crime scene desription:
SELECT description
FROM crime_scene_reports
WHERE month = 7 AND day = 28
AND street = 'Humphrey Street';

-- Find interviews of three witnesses:
SELECT transcript
  FROM interviews
 WHERE month = 7 AND day = 28
   AND transcript LIKE '%thief%';

-- From the second interview, find a list of suspects who withdrew money from Leggett Street:
SELECT DISTINCT name, phone_number, passport_number, license_plate
  FROM people
  JOIN bank_accounts ON people.id = bank_accounts.person_id
  JOIN atm_transactions ON atm_transactions.account_number = bank_accounts.account_number
 WHERE atm_transactions.account_number IN (
SELECT account_number 
  FROM atm_transactions 
 WHERE month = 7 AND day = 28 
   AND atm_location = 'Leggett Street' 
   AND transaction_type = 'withdraw');

-- Suspects: Bruce, Diana, Brooke, Kenny, Iman, Luca, Taylor, Benista.

-- From the third interview, find a list of phone calls that lasted less than a minute.
SELECT caller, receiver, duration
  FROM phone_calls 
 WHERE month = 7 AND day = 28 AND duration < 60;

 -- By comparing with the phone numbers of the suspects, we remove people who are not in the list of calls.
 -- Suspects: Bruce, Diana, Kenny, Taylor, Benista.

 -- From the first interview, find a time-sorted list of people who were in the bakery.
 SELECT name, hour, minute, activity 
   FROM bakery_security_logs 
   JOIN people ON people.license_plate = bakery_security_logs.license_plate 
  WHERE month = 7 AND day = 28 AND hour = 10 
    AND minute >= 15 AND minute <= 25;

  -- Suspects: Bruce (exit 10:18) and Diana (exit 10:23).

  -- Check Bruce and find his departure date.
  SELECT day, hour, minute 
    FROM flights 
    JOIN passengers ON passengers.flight_id = flights.id
    JOIN people ON passengers.passport_number = people.passport_number
   WHERE people.passport_number = (
  SELECT passport_number FROM people WHERE name = 'Bruce');

-- Check Diana and find her departure date.
SELECT day, hour, minute 
  FROM flights 
  JOIN passengers ON passengers.flight_id = flights.id
  JOIN people ON passengers.passport_number = people.passport_number
 WHERE people.passport_number = (
SELECT passport_number FROM people WHERE name = 'Diana');

-- The THIEF is Bruce because he has an early flight and Diana flies every day from Fiftyville.

-- Find where the thief escaped to:
SELECT city 
  FROM airports 
  JOIN flights ON flights.destination_airport_id = airports.id 
 WHERE month = 7 AND day = 29 AND hour = 8 AND minute = 20;

-- Find accomplice:
SELECT DISTINCT name 
  FROM people
  JOIN phone_calls ON phone_calls.receiver = people.phone_number
 WHERE phone_calls.receiver = '(375) 555-8161';