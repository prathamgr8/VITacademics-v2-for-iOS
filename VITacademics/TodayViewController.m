//
//  TodayViewController.m
//  VITacademics
//
//  Created by Siddharth on 14/12/13.
//  Copyright (c) 2013 Siddharth Gupta. All rights reserved.
//

#import "TodayViewController.h"
#import "TimeTable.h"
#import "RMStepsController.h"
#import "CurrentClassTableViewCell.h"
#import "UpcomingClassCell.h"


#warning Bugs
/*
 Bugs / TODO:
 - [FIXED] [was due to no upload] Last Updated Label in detail View is sometime colored, and sometimes not.
 - [FIXED] Resign First Reponder in the settings screen when user click "Verify!"
 - [FIXED] Slot in Today View is getting truncated if it's more than one slot long - Labs!
 - Set 1990 date in date picker
 - Remove the string from Setting View saying facebook thingy
  
 
 - I can actually set Change Credentials to reset the app.
 */
@interface TodayViewController (){
    TimeTable *ofToday;
    NSDictionary *currentClass;
}

@end

@implementation TodayViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];

    //NSString *sampleTTString = @"valid%[{\"sl_no\": \"1\", \"slot\": \"C1\", \"code\": \"ECE201\", \"ltpc\": \"3 0 0 3\", \"bl\": \"CBL\", \"title\": \"Probability Theory and Random Process\", \"venue\": \"TT631\", \"class_nbr\": \"2203\", \"status\": \"Registered and Approved\", \"faculty\": \"CHRISTOPHER CLEMENT J - SENSE\", \"bill_date\": \"NIL / NIL\"}, {\"sl_no\": \"2\", \"slot\": \"F1\", \"code\": \"ECE202\", \"ltpc\": \"3 0 0 3\", \"bl\": \"CBL\", \"title\": \"Transmission Lines and Fields\", \"venue\": \"TT523\", \"class_nbr\": \"2221\", \"status\": \"Registered and Approved\", \"faculty\": \"LAVANYA N - SENSE\", \"bill_date\": \"NIL / NIL\"}, {\"sl_no\": \"3\", \"slot\": \"E1\", \"code\": \"ECE203\", \"ltpc\": \"3 0 0 3\", \"bl\": \"CBL\", \"title\": \"Modulation Techniques\", \"venue\": \"TT332\", \"class_nbr\": \"2232\", \"status\": \"Registered and Approved\", \"faculty\": \"CHRISTINA JOSEPHINE MALATHI A - SENSE\", \"bill_date\": \"NIL / NIL\"}, {\"sl_no\": \"-\", \"slot\": \"L29+L30\", \"code\": \"ECE203\", \"ltpc\": \"0 0 2 1\", \"bl\": \"LBC\", \"title\": \"Modulation Techniques\", \"venue\": \"TT135\", \"class_nbr\": \"3609\", \"status\": \"Registered and Approved\", \"faculty\": \"VINOTH BABU K - SENSE\", \"bill_date\": \"NIL / NIL\"}, {\"sl_no\": \"4\", \"slot\": \"D1\", \"code\": \"ECE204\", \"ltpc\": \"3 0 0 3\", \"bl\": \"PBL\", \"title\": \"Analog Circuit Design\", \"venue\": \"TT630\", \"class_nbr\": \"2252\", \"status\": \"Registered and Approved\", \"faculty\": \"RAJEEV PANKAJ NELAPATI - SENSE\", \"bill_date\": \"NIL / NIL\"}, {\"sl_no\": \"-\", \"slot\": \"L41+L42\", \"code\": \"ECE204\", \"ltpc\": \"0 0 2 1\", \"bl\": \"LBC\", \"title\": \"Analog Circuit Design\", \"venue\": \"TT238\", \"class_nbr\": \"3668\", \"status\": \"Registered and Approved\", \"faculty\": \"SUCHENDRANATH POPURI - SENSE\", \"bill_date\": \"NIL / NIL\"}, {\"sl_no\": \"5\", \"slot\": \"A2+TA2\", \"code\": \"ECE205\", \"ltpc\": \"3 0 0 3\", \"bl\": \"CBL\", \"title\": \"Electrical and Electronic Measurements\", \"venue\": \"TT716\", \"class_nbr\": \"2341\", \"status\": \"Registered and Approved\", \"faculty\": \"KATHIRVELAN J - SENSE\", \"bill_date\": \"NIL / NIL\"}, {\"sl_no\": \"6\", \"slot\": \"B1\", \"code\": \"ENG102\", \"ltpc\": \"2 0 0 2\", \"bl\": \"CBL\", \"title\": \"English for Engineers - II\", \"venue\": \"SMV122\", \"class_nbr\": \"1832\", \"status\": \"Registered and Approved by Academics\", \"faculty\": \"PREETHA R - SSL\", \"bill_date\": \"72228 / 18-Jan-2013\"}, {\"sl_no\": \"-\", \"slot\": \"L51+L52\", \"code\": \"ENG102\", \"ltpc\": \"0 0 2 1\", \"bl\": \"LBC\", \"title\": \"English for Engineers - II\", \"venue\": \"SJT720\", \"class_nbr\": \"3368\", \"status\": \"Registered and Approved by Academics\", \"faculty\": \"PREETHA R - SSL\", \"bill_date\": \"72228 / 18-Jan-2013\"}, {\"sl_no\": \"7\", \"slot\": \"G2\", \"code\": \"HUM121\", \"ltpc\": \"2 0 0 2\", \"bl\": \"PBL\", \"title\": \"Ethics and Values\", \"venue\": \"TT531\", \"class_nbr\": \"1386\", \"status\": \"Registered and Approved\", \"faculty\": \"RAJA RAJESWARI G - SSL\", \"bill_date\": \"NIL / NIL\"}, {\"sl_no\": \"-\", \"slot\": \"L10+L11\", \"code\": \"HUM121\", \"ltpc\": \"0 0 2 1\", \"bl\": \"LBC\", \"title\": \"Ethics and Values\", \"venue\": \"TT335\", \"class_nbr\": \"3534\", \"status\": \"Registered and Approved\", \"faculty\": \"VIJAYARAJ K - SSL\", \"bill_date\": \"NIL / NIL\"}]";
    
    if([preferences objectForKey:@"registrationNumber"]){
        
        NSString *ttKey = [NSString stringWithFormat:@"TTOf%@", [preferences objectForKey:@"registrationNumber"]];
        
        ofToday = [[TimeTable alloc] initWithTTString:[preferences objectForKey:ttKey]];
        self.todaysTimeTable = [ofToday getTodaysTimeTable];
        currentClass = [[ofToday getCurrentClass] isKindOfClass:[NSDictionary class]] ? [ofToday getCurrentClass] : 0;
        
        self.legibleTimeTable = [[NSMutableArray alloc] init];
        
        NSInteger length = [self.todaysTimeTable count];
        for(int i = 0 ; i<length ; i++){
            if([self.todaysTimeTable[i] isKindOfClass:[NSDictionary class]]){
                [self.legibleTimeTable addObject:self.todaysTimeTable[i]];
            }
        }
        
        self.timeSlots = [ofToday getTimeSlotArray];
        
        [NSTimer scheduledTimerWithTimeInterval:7.0 target:self selector:@selector(refreshTable) userInfo:nil repeats:YES];
    }
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(reloadSelf)
     name:@"reloadTimeTable"
     object:nil];

    //self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%lu", (unsigned long)[self.todaysTimeTable count]];
    
}

-(void)refreshTable{
    [self.tableView reloadData];
    NSLog(@"refreshed table");
}

-(void)reloadSelf{
    NSLog(@"NotificationRcvd");
    [self viewDidLoad];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{    
    if(self.notificationReceived){
        return 3;
    }
    else{
        return 2;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    
    NSString *string = @"";
    
    if(section == 1){
        string = @"Information here might be errornous, please verify atleast once with actual time table.";
    }
    
    return string;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *string = @"Others";
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    NSString *todaysDay = [dateFormatter stringFromDate:[NSDate date]];
    
    string = @"Today";
    
    if(section == 0){
        string = @"Right Now";
    }
    
    if(section == 1){
        if([todaysDay isEqualToString:@"Monday"]){
        }
        else if([todaysDay isEqualToString:@"Tuesday"]){
        }
        else if([todaysDay isEqualToString:@"Wednesday"]){
        }
        else if([todaysDay isEqualToString:@"Thursday"]){
            
        }
        else if([todaysDay isEqualToString:@"Friday"]){
        }
        else{
            string = @"Coming Up - On Monday";
        }
    }

    if(section == 2){
        string = @"Notifications";
    }
    
    return string;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 1;
    
    
    if(section == 1){
        rows = [self.legibleTimeTable count];
    }
    
    return rows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int height = 183;

    if(indexPath.section == 1){
        height = 91;
    }
    
    return height;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
    
#warning Added this:
    currentClass = [[ofToday getCurrentClass] isKindOfClass:[NSDictionary class]] ? [ofToday getCurrentClass] : 0;
    if(currentClass){
        
        
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CurrentClassTableViewCell" owner:self options:nil];
        CurrentClassTableViewCell *cell = [nib objectAtIndex:0];
        cell.subjectTitle.text = [currentClass objectForKey:@"title"];
        cell.subjectSlot.text = [currentClass objectForKey:@"slot"];
        cell.subjectVenue.text = [currentClass objectForKey:@"venue"];
        cell.subjectFaculty.text = [currentClass objectForKey:@"faculty"];
        
        UIFont *titleFont = [UIFont fontWithName:@"MuseoSans-300" size:21];
        [cell.subjectTitle setFont:titleFont];
        [cell.subjectVenue setFont:titleFont];
        
        UIFont *percentageFont = [UIFont fontWithName:@"MuseoSans-300" size:37];
        [cell.subjectPercentage setFont:percentageFont];
        [cell.ifYou setAlpha:0.4];
        
        UIFont *greyedFont = [UIFont fontWithName:@"MuseoSans-300" size:13];
        [cell.greyedText setFont:greyedFont];
        
        UIFont *facultyFont = [UIFont fontWithName:@"MuseoSans-300" size:16];
        [cell.subjectFaculty setFont:facultyFont];
        
        UIFont *ifYouFont = [UIFont fontWithName:@"MuseoSans-300" size:30];
        [cell.ifYou setFont:ifYouFont];
        
        UIFont *calculatedFont = [UIFont fontWithName:@"MuseoSans-300" size:15];
        [cell.calculatedLabels setFont:calculatedFont];
        
        return cell;
        
    }
    else{
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NoClassRightNow" owner:self options:nil];
        UITableViewCell *cell = [nib objectAtIndex:0];
        return cell;
        }
    

    }
    
    if(indexPath.section == 1){
        
        //find the index of the subject
        int index = 0;
        for(int i=0; i<12; i++){
            if([self.todaysTimeTable[i] isKindOfClass:[NSDictionary class]]){
                if([self.legibleTimeTable[indexPath.row] isEqualToDictionary:self.todaysTimeTable[i]]){
                    index = i;
                    break;
                }
            }
            
        }
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UpcomingClassCell" owner:self options:nil];
        UpcomingClassCell *cell = [nib objectAtIndex:0];
        
        cell.subjectTitle.text = [self.legibleTimeTable[indexPath.row] objectForKey:@"title"];
        cell.subjectVenue.text = [self.legibleTimeTable[indexPath.row] objectForKey:@"venue"];
        cell.subjectSlot.text = [self.legibleTimeTable[indexPath.row] objectForKey:@"slot"];
        
        UIFont *titleFont = [UIFont fontWithName:@"MuseoSans-300" size:15];
        [cell.subjectTitle setFont:titleFont];
        
        UIFont *venueFont = [UIFont fontWithName:@"MuseoSans-300" size:19];
        [cell.subjectVenue setFont:venueFont];
        
        UIFont *slotFont = [UIFont fontWithName:@"MuseoSans-300" size:13];
        [cell.subjectSlot setFont:slotFont];
        
        UIFont *greyedFont = [UIFont fontWithName:@"MuseoSans-300" size:13];
        [cell.greyedText setFont:greyedFont];
        
        //UIFont *percentageFont = [UIFont fontWithName:@"MuseoSans-300" size:23];
        [cell.subjectPercentage setFont:greyedFont];
        cell.subjectPercentage.text = @"attendance not yet available";
        
        NSDateComponents *rightNow = [[NSCalendar currentCalendar] components:NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:[NSDate date]];
        
        NSString *suffix = @"AM";
        int time = [self.timeSlots[index] hour];
        
        if([rightNow hour] > time /*&& [rightNow minute] > 50*/){
            cell.subjectStartingIn.text = @"class finished";
            cell.subjectStartingIn.textColor = [UIColor colorWithRed:0.203 green:0.286 blue:0.386 alpha:1];
        }
        else{
            if(time > 12){
                suffix = @"PM";
                time = time - 12;
            }
            cell.subjectStartingIn.text = [NSString stringWithFormat:@"Begins at %d %@", time, suffix];
            cell.subjectStartingIn.textColor = [UIColor colorWithRed:0.203 green:0.286 blue:0.386 alpha:1];
        }
        return cell;
    }
    
    else{
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        return cell;
    }
    
}


@end
