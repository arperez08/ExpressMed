//
//  RegistrationViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 7/11/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "RegistrationViewController.h"
#import "TSPopoverController.h"
#import "TSActionSheet.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Constants.h"
#import "LoginViewController.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController
@synthesize scrollView;
@synthesize txtSSN, txtLastName, txtFirstName,txtMiddle, txtDOB, txtEmail, txtPasswrod, txtRePassword;
@synthesize btnTems,txtSecQuestion,txtAnswer;
@synthesize privacyChecked, termsChecked;
@synthesize txtDLicense,txtTitle,txtUserName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) alertStatus:(NSString *)msg :(NSString *)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(BOOL)connected {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus currrentStatus = [reachability currentReachabilityStatus];
    return currrentStatus;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (termsChecked == YES) {
        [btnTems setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        termsCheckbox = YES;
    }
    else{
        [btnTems setImage:nil forState:UIControlStateNormal];
        termsCheckbox = NO;
    }
    
    [self.navigationController setNavigationBarHidden:YES];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, 930);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];

    [btnBday addTarget:self action:@selector(showBDay:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btnSecurity addTarget:self action:@selector(showSecQuestions:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    txtSSN.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" SSN" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    txtDLicense.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" DL License" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    txtLastName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Last Name" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    txtFirstName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" First Name" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    txtMiddle.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Middle Name" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    txtDOB.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Date of Birth" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Email Address" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    txtPasswrod.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Password" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    txtRePassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Re-Enter Password" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    txtSecQuestion.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Select Question" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    txtAnswer.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Answer" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    txtTitle.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Title" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    txtUserName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Username" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    
    arrayQuestions=[[NSMutableArray alloc]initWithObjects:
                    @"Select Question",
                    @"Who is your favorite actor, musician, or artist?",
                    @"What is the name of your favorite pet?",
                    @"In what city were you born?",
                    @"What high school did you attend?",
                    @"What is the name of your first school?",
                    @"What is your favorite movie?",
                    @"What is your mother's maiden name?",
                    @"What street did you grow up on?",
                    @"What was the make of your first car?",
                    @"When is your anniversary?",
                    @"What is your favorite color?",
                    @"What is your father's middle name?",
                    @"What is the name of your first grade teacher?",
                    @"What was your high school mascot?",
                    @"Which is your favorite web browser?",
                    nil];
}

-(void)dismissKeyboard {
    [txtSSN resignFirstResponder];
    [txtDLicense resignFirstResponder];
    [txtLastName resignFirstResponder];
    [txtFirstName resignFirstResponder];
    [txtMiddle resignFirstResponder];
    [txtDOB resignFirstResponder];
    [txtEmail resignFirstResponder];
    [txtPasswrod resignFirstResponder];
    [txtRePassword resignFirstResponder];
    [txtAnswer resignFirstResponder];
    [txtUserName resignFirstResponder];
    [txtTitle resignFirstResponder];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    BOOL lowerCaseLetter = 0;
    BOOL upperCaseLetter = 0;
    BOOL digit =0;
    BOOL specialCharacter = 0;
    if([textField.text length] >= 5)
    {
        for (int i = 0; i < [txtPasswrod.text length]; i++)
        {
            unichar c = [txtPasswrod.text characterAtIndex:i];
            if(!lowerCaseLetter)
            {
                lowerCaseLetter = [[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:c];
            }
            if(!upperCaseLetter)
            {
                upperCaseLetter = [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:c];
            }
            if(!digit)
            {
                digit = [[NSCharacterSet decimalDigitCharacterSet] characterIsMember:c];
            }
            if(!specialCharacter)
            {
                specialCharacter = [[NSCharacterSet symbolCharacterSet] characterIsMember:c];
            }
        }
        
        if(specialCharacter && digit && lowerCaseLetter && upperCaseLetter)
        {
            //do what u want
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password"
                                                            message:@"Please Ensure that you have at least \n one lower case letter \n one upper case letter \n one digit \n one special character"
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password"
                                                        message:@"Please Enter at least 6 password"
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}



-(BOOL) NSStringIsValidEmail:(NSString *)checkString {
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)btnSubmit:(id)sender {
    if ([self connected] == NotReachable){
        [self alertStatus:@"No Network Connection" :@"Notification"];
    }
    else{
        [self dismissKeyboard];
        [self validateData];
    }
}

- (void) validateData{
    if (([txtLastName.text isEqualToString:@""]) || ([txtFirstName.text isEqualToString:@""]) || ([txtDOB.text isEqualToString:@""]) || ([txtEmail.text isEqualToString:@""]) || ([txtUserName.text isEqualToString:@""]) || ([txtPasswrod.text isEqualToString:@""])) {

        if ([txtUserName.text isEqualToString:@""]) {
            [self alertStatus:@"Username is required." :@"Error"];
        }
        else if ([txtLastName.text isEqualToString:@""]) {
            [self alertStatus:@"Last Name is required." :@"Error"];
        }
        else if ([txtFirstName.text isEqualToString:@""]) {
            [self alertStatus:@"First Name is required." :@"Error"];
        }
        else if ([txtDOB.text isEqualToString:@""]) {
            [self alertStatus:@"Date of Birth is required." :@"Error"];
        }
        else if ([txtEmail.text isEqualToString:@""]) {
            [self alertStatus:@"Email is required." :@"Error"];
        }
        else if ([txtPasswrod.text isEqualToString:@""]) {
            [self alertStatus:@"Password is required." :@"Error"];
        }
    }
    else{
        if ([self NSStringIsValidEmail:txtEmail.text]){
            if ([txtPasswrod.text isEqual:txtRePassword.text]) {
                if (!termsCheckbox) {
                    [self alertStatus:@"Please accept terms and conditions" :@"Error"];
                }
                else{
                    HUB = [[MBProgressHUD alloc]initWithView:self.view];
                   [self.view addSubview:HUB];
                    HUB.labelText = @"Retrieving and validating data…";
                    [HUB showWhileExecuting:@selector(submitData) onTarget:self withObject:nil animated:YES];
                }
            }
            else{
                [self alertStatus:@"Password did not match" :@"Error"];
            }
        }
        else{
            [self alertStatus:@"Invalid email address" :@"Error"];
        }
    }
}


- (void) submitData {
    NSString * strPortalURL = [NSString stringWithFormat:PORTAL_URL,@"RegisterUser"];
    NSLog(@"strURL: %@",strPortalURL);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strPortalURL]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
    [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
    [request setPostValue:txtFirstName.text forKey:@"strFirstName"];
    [request setPostValue:txtMiddle.text forKey:@"strMiddleName"];
    [request setPostValue:txtLastName.text forKey:@"strLastName"];
    [request setPostValue:txtDOB.text forKey:@"strDOB"];
    [request setPostValue:txtEmail.text forKey:@"strEmailAdd"];
    [request setPostValue:txtPasswrod.text forKey:@"strPassword"];
    [request setPostValue:txtSecQuestion.text forKey:@"strSecQst"];
    [request setPostValue:txtAnswer.text forKey:@"strSecAns"];
    [request setPostValue:txtSSN.text forKey:@"strSSN"];
    [request setPostValue:txtDLicense.text forKey:@"strDLicense"];
    [request setPostValue:txtUserName.text forKey:@"strUserName"];
    [request setPostValue:txtTitle.text forKey:@"strTitle"];
    [request startSynchronous];
    NSData *urlData = [request responseData];
    NSError *error = [request error];
    if (!error) {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"responseData: %@",responseData);
        NSMutableArray *arrayData = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error:nil];
        NSMutableDictionary *dictData = [arrayData objectAtIndex:0];
        NSString *strStatus = [NSString stringWithFormat:@"%@",[dictData objectForKey:@"strStatus"]];
        if ([strStatus isEqualToString:@"Success"]) {
            [self alertStatus:@"Registeration successfull, please check your registered email address for more information." :@"Success"];
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                LoginViewController *Lvc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
                [self.navigationController setNavigationBarHidden:YES];
                [self.navigationController pushViewController:Lvc animated:YES];
            }
            else{
                LoginViewController *Lvc = [[LoginViewController alloc] initWithNibName:@"LoginViewController_iPad" bundle:[NSBundle mainBundle]];
                [self.navigationController setNavigationBarHidden:YES];
                [self.navigationController pushViewController:Lvc animated:YES];
            }
        }
        else{
            [self alertStatus:strStatus :@"Error"];
        }
    }
    else{
        [self alertStatus:[NSString stringWithFormat:@"%@",error] :@"Error"];
        NSLog(@"error: %@",error);
    }
}



- (IBAction)btnTerms:(id)sender {
    if (!termsCheckbox) {
        [btnTems setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        termsCheckbox = YES;
    }
    else if (termsCheckbox) {
        [btnTems setImage:nil forState:UIControlStateNormal];
        termsCheckbox = NO;
    }
}

-(void)updateTextField:(id)sender{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    //txtBday.text = [dateFormat stringFromDate:BdayPicker.date];
    //bdayString = BdayPicker.date;
    txtDOB.text = [dateFormat stringFromDate:BdayPicker.date];
}


-(void)showBDay:(id)sender forEvent:(UIEvent*)event{
    [self dismissKeyboard];
    UIViewController *bdayNameView = [[UIViewController alloc]init];
    bdayNameView.view.frame = CGRectMake(0,0, 300, 150);
    BdayPicker = [[UIDatePicker alloc] init];
    BdayPicker.frame  = CGRectMake(0,0, 300, 100);
    BdayPicker.datePickerMode = UIDatePickerModeDate;
    [bdayNameView.view addSubview:BdayPicker];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];

    if (![txtDOB.text  isEqual: @""]){
        BdayPicker.date = [dateFormat dateFromString:txtDOB.text];
        [BdayPicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    }
    else{
        //BdayPicker.date = [dateFormat dateFromString:@"Jan 01, 1970"];
        [BdayPicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    }
    TSPopoverController *popoverController = [[TSPopoverController alloc] initWithContentViewController:bdayNameView];
    popoverController.cornerRadius = 10;
    popoverController.popoverBaseColor = [UIColor whiteColor];
    popoverController.popoverGradient= NO;
    [popoverController showPopoverWithTouch:event];
}

-(void)showSecQuestions:(id)sender forEvent:(UIEvent*)event{
    [self dismissKeyboard];
    UIViewController *prodNameView = [[UIViewController alloc]init];
    prodNameView.view.frame = CGRectMake(0,0, 320, 162);
    securityQuestion = [[UIPickerView alloc] init];
    securityQuestion.frame  = CGRectMake(0,0, 320, 162);
    securityQuestion.showsSelectionIndicator = YES;
    securityQuestion.delegate = self;
    securityQuestion.dataSource = self;
    [prodNameView.view addSubview:securityQuestion];
    TSPopoverController *popoverController = [[TSPopoverController alloc] initWithContentViewController:prodNameView];
    popoverController.cornerRadius = 0;
    popoverController.popoverBaseColor = [UIColor whiteColor];
    popoverController.popoverGradient= YES;
    [popoverController showPopoverWithTouch:event];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return [arrayQuestions count];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (thePickerView == securityQuestion) {
        NSString* questions = [arrayQuestions objectAtIndex:row];
        if ((![questions  isEqual: @"Select Question"]) || !questions) {
            [txtSecQuestion setText:questions];
        }
    }
}

- (UIView *)pickerView:(UIPickerView *)thePickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* tView = (UILabel*)view;
    if (!tView){
        tView = [[UILabel alloc] init];
        [tView setTextAlignment:NSTextAlignmentCenter];
        [tView setLineBreakMode:0];
    }
    if (thePickerView == securityQuestion) {
        [tView setFont:[UIFont fontWithName:@"Helvetica" size:14]];
        NSString* countryName = [arrayQuestions objectAtIndex:row];
        tView.text=countryName;
    }
    return tView;
}


@end
