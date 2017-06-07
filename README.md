# The automated fEMR user entry system from heaven
Every single time a new team uses fEMR they have a ton of users to add and it's really annoying. 

## Depenencies
* Ruby 

## Formatting your CSV file
* Use accounts.csv.example file as an example
* Columns: Last,First,Email,Profession,Agency,Role,Role
  * Profession and Agency get combined and loaded into the notes field
* Character Set: UTF-8
* Field delimiter: ,
* Do NOT quote values
* Do NOT include commas anywhere
* DO remove all headers. The column headers shouldn't exist. Only the rows of data.
* DO have a file named accounts.csv in the main directory when you run execute_users.sh

## Usage example:
```Shell
cd /path/to/femr-user-uploader
mv /path/to/accounts.csv .
./buy_cookies.rb -u admin -p admin -f cookies.txt -i http://localhost:9000
./execute_users.sh
./cleanup.rb -f cookies.txt
```

## Disclaimer:
* This has only been tested with perfect CSV files that fit the rules in the formatting section above. No idea what happens when SHTF
