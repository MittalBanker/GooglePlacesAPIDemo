//
//  CustomUIView.h
//  vMall
//
//  Created by digicorp on 10/18/12.
//  Copyright (c) 2012 digicorp. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    CustomMenuArrowAlignmentCenter,
	CustomMenuArrowAlignmentLeft,
	CustomMenuArrowAlignmentRight
} CustomMenuArrowAlignment;


@protocol CustomMenuViewDelegate
- (void)CustomMenuButtonTappedWithTitle:(NSString*)title;
@end;

@interface CustomMenuView : UIView
{
    //for ios 5.0 issue
    __unsafe_unretained id<CustomMenuViewDelegate>delegate;
    UIView *viewPopOver;
    UIImageView *imgArrow;
    
}
@property (nonatomic, assign)id <CustomMenuViewDelegate> delegate;
@property (nonatomic,retain)UIImageView *imgArrow;

-(IBAction)menuButtonTapped:(id)sender;
-(void)setArrowPosition:(CustomMenuArrowAlignment)position;
-(void)addMenuButtonsWithTitles:(NSArray*)titles;
-(void)setMenuPosition:(CGPoint)point;

-(void)setOptionsWithTitles:(NSArray*)titles andPosition:(CGPoint)position andArrowPosition:(CustomMenuArrowAlignment)alignmetposition;
@end

