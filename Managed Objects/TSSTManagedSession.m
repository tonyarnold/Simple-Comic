//
//  TSSTManagedSession.m
//  SimpleComic
//
//  Created by Alexander Rauchfuss on 2/9/08.
//  Copyright 2008 Dancing Tortoise Software. All rights reserved.
//

#import "TSSTManagedSession.h"
#import "TSSTManagedGroup.h"

@implementation TSSTManagedSession


/*	The whole point of this method is to check for files in a session.
	Making sure they are still there.  If not they are deleted. */
- (void)awakeFromFetch
{
	[super awakeFromFetch];
	TSSTManagedGroup * group;
	NSData * bookmarkData;
	NSString * hardPath;
	NSURL * savedBookmark;
	for (group in [self valueForKey:@"groups"])
	{
		bookmarkData = [group valueForKey: @"pathData"];
		if (bookmarkData != nil)
		{
			savedBookmark = [self urlForBookmark:bookmarkData];
			hardPath = [savedBookmark path];
			if(!hardPath)
			{
				[group setValue: nil forKey: @"session"];
				[[self managedObjectContext] deleteObject: group];
			}
		}
	}
}

- (NSURL*)urlForBookmark:(NSData*)bookmark {
    BOOL bookmarkIsStale = NO;
    NSError* theError = nil;
    NSURL* bookmarkURL = [NSURL URLByResolvingBookmarkData:bookmark options:NSURLBookmarkResolutionWithoutUI relativeToURL:nil bookmarkDataIsStale:&bookmarkIsStale error:&theError];

    if (bookmarkIsStale || (theError != nil)) {
		[NSApp presentError:theError];
        return nil;
    }
    return bookmarkURL;
}

//- (void)savePageOrder
//{
//	NSSet * groups = [self valueForKey: @"groups"];
//}


@end
