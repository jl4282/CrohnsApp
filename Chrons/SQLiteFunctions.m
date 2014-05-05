//
//  SQLiteFunctions.m
//  Chrons
//
//  Created by Bernando Vialli on 4/28/14.
//  Copyright (c) 2014 nyu.edu. All rights reserved.
//

#import "SQLiteFunctions.h"
#import <sqlite3.h>


@implementation SQLiteFunctions
//@synthesize SQLVariable;
@synthesize query;
-(void)aggregateDataForMeal: (NSArray*)foodEaten
                    andTime:(NSString*)mealTime
                   andSauce: (NSString*)sauce
                  andDrinks:(NSString*)drinks
             andDescription: (NSString*)mealDescription
                  andSpices:(NSString*)mealSpices
                    andSize:(NSString*)size
                  andCooked:(NSString*)cooked{
    //NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO MEAL VALUES (%@, %@, %@, %@, %@, %@ %@ %@)",
    //                     foodEaten,mealTime,sauce,drinks,mealDescription,mealSpices,size,mealMood];
    
    /*for(id obj in foodEaten){
     NSLog(@"%@",obj);
     }*/
    query = [NSString stringWithFormat:@"INSERT INTO meal VALUES(null, \"%@\", \"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\") ", cooked, mealTime, sauce, drinks, mealDescription, mealSpices, size];
    NSLog(@"%@ mealtime",mealTime);
    [self insertIntoDatabase:query];
    int mealNumber = [self getMaxIDInMeal];
    //get meal number of latest entry (max ID)
    for (int i=0; i<[foodEaten count]; i++) {
        [self insertIntoFoodAtMeal:[foodEaten objectAtIndex:i] atMeal: mealNumber];
    }
}
-(int) getMaxIDInMeal{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.db"];
    int result;
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        query = @"SELECT MAX(ID) from meal";
        const char *sql = [query UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
            while (sqlite3_step(statement) == SQLITE_ROW) {
                // The second parameter indicates the column index into the result set.
                result = sqlite3_column_int(statement, 0);
            }
        }
        sqlite3_finalize(statement);
    } else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
    }
    sqlite3_close(database);
    NSLog(@"%d",result);
    return result;
}

-(void)insertIntoFoodAtMeal: (NSString*)nameOfFood
                     atMeal: (int)mealNumberID{
    query = [NSString stringWithFormat:@"INSERT INTO foodAtMeal VALUES(null, \"%@\", %d)", nameOfFood, mealNumberID];
    [self insertIntoDatabase:query];
}




-(void)insertIntoPain: (NSString*) timeOfPain
        andPainRating: (int)painRating
          andLocation: (NSString*) painLocation
       andDescription: (NSString*) painDescription;
{
    // update from brandon
    query = [NSString stringWithFormat:@"INSERT INTO pain VALUES(null, \"%@\" , %i, \"%@\", \"%@\")",timeOfPain,painRating,painLocation,painDescription];
    [self insertIntoDatabase:query];
}
-(void)insertIntoAccount: (NSString*)name
           andFamHistory:(NSString*)FamilyHistory
              andSmoking: (int) packsADay
              andAlcohol: (int) alcoholFrequency
             andAlergies: (NSString*) alergies{
    query = [NSString stringWithFormat:@"INSERT INTO account VALUES(null, \"%@\", %d, %d, \"%@\", \"%@\" )", name, alcoholFrequency, packsADay, alergies, FamilyHistory];
    [self insertIntoDatabase:query];
    
}
-(void)insertIntoFoodTable: (NSString*)foodName{
    query = [NSString stringWithFormat:@"INSERT INTO food VALUES(\"%@\")", foodName];
    [self insertIntoDatabase:query];
}

-(void)insertIntoBM: (NSString*) timeOfPain
            andSize:(NSString*) sizeOfBM
           andColor:(NSString*) colorOfBM
           andBlood:(int) blood
         andUrgency:(int) urgency
     andDescription:(NSString*) description
    andConstipation:(int)constipationBool
        andDiarrhea:(int)diarrheaBool{
    query = [NSString stringWithFormat:@"INSERT INTO bm VALUES(null, \"%@\", \"%@\", \"%@\", %d, %d, \"%@\", %d, %d)",timeOfPain, sizeOfBM, colorOfBM, blood, urgency, description, constipationBool, diarrheaBool];
    [self insertIntoDatabase:query];
}

-(void)insertIntoColor: (NSString*)color{
    query = [NSString stringWithFormat:@"INSERT INTO color VALUES(\"%@\")", color];
    [self insertIntoDatabase:query];
}
-(void)insertIntoCooked: (NSString*) howItWasCooked{
    query = [NSString stringWithFormat:@"INSERT INTO cooked VALUES(\"%@\")", howItWasCooked];
    [self insertIntoDatabase:query];
}

-(void)insertIntoSauce: (NSString*) sauceName{
    query = [NSString stringWithFormat:@"INSERT INTO sauce VALUES(\"%@\")", sauceName];
    [self insertIntoDatabase:query];
}

-(void)insertIntoDrinks: (NSString*) drinkName{
    query = [NSString stringWithFormat:@"INSERT INTO drinks VALUES(\"%@\")", drinkName];
    [self insertIntoDatabase:query];
}

-(void)insertIntoSpices: (NSString*) spicesName{
    query = [NSString stringWithFormat:@"INSERT INTO spices VALUES(\"%@\")", spicesName];
    [self insertIntoDatabase:query];
}

-(void)insertIntoConsistency: (NSString*) consistency{
    query = [NSString stringWithFormat:@"INSERT INTO consistency VALUES(\"%@\")", consistency];
    [self insertIntoDatabase:query];
}

-(void)insertIntoSize: (NSString*) size{
    query = [NSString stringWithFormat:@"INSERT INTO size VALUES(\"%@\")", size];
    [self insertIntoDatabase:query];
}

-(void)insertIntoBlood: (NSString*) blood{
    query = [NSString stringWithFormat:@"INSERT INTO blood VALUES(\"%@\")", blood];
    [self insertIntoDatabase:query];
}
-(void)insertIntoUrgency: (NSString*) urgency{
    query = [NSString stringWithFormat:@"INSERT INTO urgency VALUES(\"%@\")", urgency];
    [self insertIntoDatabase:query];
}

-(void)insertIntoPainLocations: (NSString*)painLocation{
    query = [NSString stringWithFormat:@"INSERT INTO painLocations VALUES(\"%@\")", painLocation];
    [self insertIntoDatabase:query];
}

-(void)insertIntoMood: (NSString*)mood{
    query = [NSString stringWithFormat:@"INSERT INTO mood VALUES(\"%@\")", mood];
    [self insertIntoDatabase:query];
}

-(void)insertIntoMedName: (NSString*)medName{
    query = [NSString stringWithFormat:@"INSERT INTO medName VALUES(\"%@\")", medName];
    [self numberOfTimesEachFoodGivesPain];
    //  [self insertIntoDatabase:query];
    NSArray *temparray = [self numberOfTimesEachFoodGivesPain];
    NSLog(@"start");
    NSLog(@"stop");
    for (int i = 0;i < [temparray count];i++)
    {
        FoodPainAndCount *a = [temparray objectAtIndex:i];
        
        NSLog(@"%@",a.food);
    }
    //[self foodThatGivesConstipation];
    //NSLog(@"%d",[self numTimesSpecificFoodInMeals: @"Chicken"]);
}

-(NSArray*) numberOfTimesEachFoodGivesPain{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.db"];
    //create results array
    NSMutableArray *result = [NSMutableArray new];
    
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        NSLog(@"GET IN");
        query = [NSString stringWithFormat:@"SELECT count(fm.name) as numOfTimes, fm.name"
                 " FROM foodAtMeal fm"
                 " WHERE fm.name IN ("
                 " SELECT fm.name"
                 " FROM meal m, foodAtMeal fm"
                 " WHERE m.time IN (SELECT m.time"
                 " FROM pain p, meal m"
                 " WHERE datetime(p.time) <= (datetime(m.time, \'+12 hours\')) AND datetime(p.time) >= datetime(m.time)"
                 " GROUP BY m.time)"
                 " AND m.ID = fm.meal"
                 " ORDER BY m.time DESC"
                 " )"
                 " GROUP BY fm.name"
                 " ORDER BY fm.name DESC"]
        ;
        const char *sql = [query UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
            while (sqlite3_step(statement) == SQLITE_ROW) {
                // The second parameter indicates the column index into the result set.
                //get name
                NSString * temp = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                //add to object
                FoodPainAndCount* item = [[FoodPainAndCount alloc] initWith: temp andCount:sqlite3_column_int(statement, 0)];
                //NSLog(@"%d",sqlite3_column_int(statement, 0));
                //add object to array
                [result addObject:item];
            }
        }
        sqlite3_finalize(statement);
        
    } else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
    }
    sqlite3_close(database);
     return result;
}

-(NSArray*) foodThatGivesDiarreah{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.db"];
    //create results array
    NSMutableArray *result = [NSMutableArray new];
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        // NSLog(@"diearrr");
        query = [NSString stringWithFormat:@"SELECT fm.name, m.time"
                 " FROM meal m, foodAtMeal fm"
                 " WHERE m.time IN (SELECT m.time"
                 " FROM bm bm, meal m"
                 " WHERE (datetime(bm.time) <= (datetime(m.time, \'+12 hours\'))) AND (datetime(m.time) <= datetime(bm.time)) AND (bm.diarrhea >= 1)"
                 " GROUP BY m.time)"
                 " AND m.ID = fm.meal"
                 " GROUP BY fm.name"
                 " ORDER BY m.time DESC"]
        ;
        const char *sql = [query UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
            while (sqlite3_step(statement) == SQLITE_ROW) {
                // The second parameter indicates the column index into the result set.
                //get name
                NSString * temp = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                //add result to arrray
                [result addObject:temp];
            }
        }
        sqlite3_finalize(statement);
        
    } else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
    }
    sqlite3_close(database);
     return result;
    
}



-(NSArray*) foodThatMakesGoToBathroomUrgent{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.db"];
    //create results array
    NSMutableArray *result = [NSMutableArray new];
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        query = [NSString stringWithFormat:@"SELECT fm.name, m.time"
                 " FROM meal m, foodAtMeal fm"
                 " WHERE m.time IN (SELECT m.time"
                 " FROM bm bm, meal m"
                 " WHERE datetime(bm.time) <= (datetime(m.time, \'+12 hours\')) AND datetime(m.time) <= datetime(bm.time) AND bm.urgency = 1"
                 " GROUP BY m.time)"
                 " AND (m.ID = fm.meal)"
                 " GROUP BY fm.name"
                 " ORDER BY m.time DESC"]
        ;
   

        const char *sql = [query UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
            while (sqlite3_step(statement) == SQLITE_ROW) {
                // The second parameter indicates the column index into the result set.
                //get name
                NSString * temp = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                //add result to arrray
                
                [result addObject:temp];
            }
        }
        sqlite3_finalize(statement);
        
    } else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
    }
    sqlite3_close(database);
    return result;
    
}


-(NSArray*) foodThatGivesConstipation{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.db"];
    //create results array
    NSMutableArray *result = [NSMutableArray new];
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        query = [NSString stringWithFormat:@"SELECT fm.name, m.time"
                 " FROM meal m, foodAtMeal fm"
                 " WHERE m.time IN (SELECT m.time"
                 " FROM bm bm, meal m"
                 " WHERE (datetime(bm.time) <= (datetime(m.time, \'+12 hours\'))) AND (datetime(m.time) <= datetime(bm.time)) AND (bm.constipation >= 1)"
                 " GROUP BY m.time)"
                 " AND m.ID = fm.meal"
                 " GROUP BY fm.name"
                 " ORDER BY m.time DESC"]
        ;
        const char *sql = [query UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
            while (sqlite3_step(statement) == SQLITE_ROW) {
                // The second parameter indicates the column index into the result set.
                //get name
                NSString * temp = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                //add result to arrray
                NSLog(@"%@",temp);
                
                [result addObject:temp];
            }
        }
        sqlite3_finalize(statement);
        
    } else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
    }
    sqlite3_close(database);
    return result;
}


-(NSArray*) percentageOfTimesFoodGivesPain{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.db"];
    //create results array for final output
    NSMutableArray *result = [NSMutableArray new];
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        query = [NSString stringWithFormat:@"SELECT count(m.ID) AS numTimes, fm.name"
                 " FROM meal m"
                 " INNER JOIN foodAtMeal fm ON (m.ID = fm.meal)"
                 " WHERE m.time IN (SELECT m.time"
                                  " FROM pain p, meal m"
                                  " WHERE (datetime(p.time) <= (datetime(m.time, \'+12 hours\'))) AND (datetime(m.time) <= datetime(p.time))"
                                  " GROUP BY m.time)"
                 " GROUP BY fm.name"
                 " ORDER BY numTimes DESC "]
        ;
        
        const char *sql = [query UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
            while (sqlite3_step(statement) == SQLITE_ROW) {
                // The second parameter indicates the column index into the result set.
                //get name
                NSString * temp = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                //add to object
                
                StringAndNumber * st = [[StringAndNumber alloc]initWith:temp andNumber:sqlite3_column_int(statement, 0)];
                
                //get total number of times it apears in all meals
                int totalTimes = [self numTimesSpecificFoodInMeals:[st string]];
                //calculate percentage
               // NSLog(@"%d",st.number);
                // NSLog(@"%@",temp);
                // NSLog(@"%d is the number of times",totalTimes);
                st.number = (st.number * 100)/totalTimes;
                
                [result addObject:st];
            }
        }
        sqlite3_finalize(statement);
        
    } else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
    }
    sqlite3_close(database);
      return result;
}

-(int) numTimesSpecificFoodInMeals: (NSString*)foodToTest{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.db"];
    //create results array
    int result;
    // Open the database. The database was \prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        query = [NSString stringWithFormat:@"SELECT count(fm.name) as numTimes, fm.name"
                 " FROM foodAtMeal fm"
                 " WHERE fm.name = \"%@\"", foodToTest]
        ;
        const char *sql = [query UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
            while (sqlite3_step(statement) == SQLITE_ROW) {
                // The second parameter indicates the column index into the result set.
                //get name
                result = sqlite3_column_int(statement, 0);
                //add result to arrray
            }
        }
        sqlite3_finalize(statement);
        
    } else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
    }
    sqlite3_close(database);
    return result;
    
}

-(NSArray*) percentageOfTimesFoodGivesDiarreah{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.db"];
    //create results array for final output
    NSMutableArray *result = [NSMutableArray new];
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        query = [NSString stringWithFormat:@"SELECT count(m.ID), fm.name"
                 " FROM meal m"
                 " INNER JOIN foodAtMeal fm ON (m.ID = fm.meal)"
                 " WHERE m.time IN (SELECT m.time"
                                  " FROM bm bm, meal m"
                                  " WHERE (datetime(bm.time) <= (datetime(m.time, '+12 hours'))) AND (datetime(m.time) <= datetime(bm.time)) AND (bm.diarrhea >= 1)"
                                  " GROUP BY m.time)"
                " GROUP BY fm.name"
                 ];
        
        const char *sql = [query UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
            while (sqlite3_step(statement) == SQLITE_ROW) {
                // The second parameter indicates the column index into the result set.
                //get name
                NSString * temp = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                //add to object
                StringAndNumber * st = [[StringAndNumber alloc]initWith:temp andNumber:sqlite3_column_int(statement, 0)];
                //get total number of times it apears in all meals
                int totalTimes = [self numTimesSpecificFoodInMeals:[st string]];
        //NSLog(@"%d temp",totalTimes);
                //calculate percentage
                st.number = (st.number * 100)/totalTimes;
                [result addObject:st];
            }
        }
        sqlite3_finalize(statement);
        
    } else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
    }
    sqlite3_close(database);
    return result;
}

-(NSArray*) percentageOfTimesFoodGivesConstipation{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.db"];
    //create results array for final output
    NSMutableArray *result = [NSMutableArray new];
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        query = [NSString stringWithFormat:@" SELECT count(m.ID), fm.name"
                 " FROM meal m"
                 " INNER JOIN foodAtMeal fm ON (m.ID = fm.meal)"
                 " WHERE m.time IN (SELECT m.time"
                                  " FROM bm bm, meal m"
                                  " WHERE (datetime(bm.time) <= (datetime(m.time, '+12 hours'))) AND (datetime(m.time) <= datetime(bm.time)) AND (bm.constipation >= 1)"
                                  " GROUP BY m.time)"
                 " GROUP BY fm.name"
                 ];
        const char *sql = [query UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
            while (sqlite3_step(statement) == SQLITE_ROW) {
                // The second parameter indicates the column index into the result set.
                //get name
                NSString * temp = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                //add to object
              //  NSLog(@"%@ temp",temp);
                StringAndNumber * st = [[StringAndNumber alloc]initWith:temp andNumber:sqlite3_column_int(statement, 0)];
                //get total number of times it apears in all meals
                int totalTimes = [self numTimesSpecificFoodInMeals:[st string]];
                //calculate percentage
               // NSLog(@"%d temp",totalTimes);
                st.number = (st.number * 100)/totalTimes;
                [result addObject:st];
            }
        }
        sqlite3_finalize(statement);
        
    } else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
    }
    sqlite3_close(database);
    return result;
    
}



-(void) insertIntoDatabase: (NSString*)finalQuery{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.db"];
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        NSLog(@"SUCCESSFULLY OPENED DATABASE");
        const char *sql = [finalQuery UTF8String];
        sqlite3_stmt *statement;
        sqlite3_prepare_v2(database, sql,-1, &statement, NULL);
        NSLog(@"Query: %@", finalQuery);
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"Added to database");
        }
        else {
            NSLog(@"Unsuccessfully added to database");
        }
        
    }// end of update
    else{
        NSLog(@"Failed to open Database");
    }
    sqlite3_close(database);
    // return 0;
}


@end

