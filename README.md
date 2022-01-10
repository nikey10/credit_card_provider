# Environment

|Environment|Description|
|------|---|
|OS|Ubuntu|
|Ruby|~>2.7|

# Install Dependencies

```
bundle install
```
# Build And Compile

Nothing

# Package Structure

|Filename|Description|
|------|---|
|myprogram|Main program of this solution|
|credit_card_provider.rb|Implementation of the class "CreditCardProvider"|
|credit_card_provider_spec.rb|rspec file|
|sample1.txt, sample2.txt|Sample input data|
|Gemfile|Defines dependencies|
|Rakefile|Test automation|
|README.md|This file|

# Run

## Method 1: Using Filename Parameter

Execute myprogram

```
./myprogram <input_file_name>
```
or
```
./myprogram < <input_file_name>
```
If permission error occurred, such as

```
bash: ./myprogram: Permission denied
```
run command below

```
chmod +x myprogram
```
then, execute myprogram again


## Method 2: Using STDIN

- Execute myprogram

    ```
    ./myprogram
    ```
- Input data
- Press "Ctrl-D"

# Testing
```
rake
```

# Overview Of Designe Decisions
- myprogram is a entrypoint of this solution
  
  myprogram creates an object of class CreditCardProvider which is initialized by data which is inputted from either file or STDIN

- This object has member variables named @cards and @command_history

  @cards is a Hash whose key is owner name and value is number, limit  and balance

  Card number and card limit are input parameters' value

  If card number is not satisfy the luhn, card balance havs value of 'error'

  @command_history is a storage to save commands

- CreditCardProvider#query is a method that saves the rusult of processing @command_history's all commands into @cards, creates sorted and shortened value of '@card'

  This is performed by calling to CreditCardProvider#process_command and CreditCardProvider#generate_summury

  Processing logic is same as requirement

- myprogram invokes CreditCardProvider#query method and outputs the result
