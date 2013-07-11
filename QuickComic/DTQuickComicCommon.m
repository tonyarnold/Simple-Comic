//
//  DTQuickComicCommon.m
//  QuickComic
//
//  Created by Alexander Rauchfuss on 11/10/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "DTQuickComicCommon.h"
#import "TSSTSortDescriptor.h"
#import <XADMaster/XADArchive.h>


static NSArray * fileNameSort = nil;


NSMutableArray * fileListForArchive(XADArchive * archive)
{
	NSMutableArray * fileDescriptions = [NSMutableArray array];
	
    NSDictionary * fileDescription;
    int count = [archive numberOfEntries];
    int index = 0;
    NSString * fileName;
	NSString * rawName;
    for ( ; index < count; ++index)
    {
        fileName = [archive nameOfEntry: index];
		XADString * dataString = [archive rawNameOfEntry: index];
		rawName = [dataString stringWithEncoding: NSNonLossyASCIIStringEncoding];
        if([[NSImage imageFileTypes] containsObject: [fileName pathExtension]])
        {
            fileDescription = @{@"name": fileName,
                               @"index": @(index),
							   @"rawName": rawName};
            [fileDescriptions addObject: fileDescription];
        }
    }
    return fileDescriptions;
}


NSArray * fileSort(void)
{
    if(!fileNameSort)
    {
        TSSTSortDescriptor * sort = [[TSSTSortDescriptor alloc] initWithKey: @"name" ascending: YES];
        fileNameSort = @[sort];
    }
    
    return fileNameSort;
}

