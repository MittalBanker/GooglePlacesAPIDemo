//
//  CustomUIView.m
//  vMall
//
//  Created by digicorp on 10/18/12.
//  Copyright (c) 2012 digicorp. All rights reserved.
//

#import "CustomMenuView.h"

@implementation CustomMenuView
@synthesize delegate;
@synthesize imgArrow;

#define ARROW_WIDTH 19.0
#define ARROW_HEIGHT 9.0

#define POPOVER_VIEW_WIDTH 110

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])){
        
        [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
        //self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_43.png"]];
        [self.layer setOpaque:NO];
        self.opaque = NO;
        
        imgArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bo_errow.png"]];
        [self addSubview:imgArrow];
        
        viewPopOver = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
        [self addSubview:viewPopOver];
    }
    return self;
}

-(void)setOptionsWithTitles:(NSArray*)titles andPosition:(CGPoint)position andArrowPosition:(CustomMenuArrowAlignment)alignmetposition{
    
    [self addMenuButtonsWithTitles:titles];
    [self setMenuPosition:position];
    [self setArrowPosition:alignmetposition];
}

-(void)addMenuButtonsWithTitles:(NSArray*)titles{
    
    int x = 2.5;
    int y = 4;
    
    int buttonHeight = 21;
    int buttonWidth = 106;
    
    NSString *strbuttonTitle;
    
    for (UIView *view in [viewPopOver subviews]) {
        if ([view isKindOfClass:[UIButton class]]){
            [view removeFromSuperview];
        }
    }
    
    for(int i=0;i<[titles count];i++){
        
        UIButton *sub_button = [UIButton buttonWithType:UIButtonTypeCustom];
        strbuttonTitle = [NSString stringWithFormat:@"%@",[titles objectAtIndex:i]];
        
        [sub_button setTitle:strbuttonTitle forState:UIControlStateNormal];
        [sub_button setFrame:CGRectMake(x, y, buttonWidth, buttonHeight)];
        
        [sub_button setBackgroundImage:[UIImage imageNamed:@"btn_43_normal.png"] forState:UIControlStateNormal];
        [sub_button setBackgroundImage:[UIImage imageNamed:@"btn_43_selected.png"] forState:UIControlStateHighlighted];
        [sub_button.titleLabel setFont:[UIFont systemFontOfSize:11]];
        [sub_button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [sub_button.titleLabel setTextAlignment:UITextAlignmentCenter];
        sub_button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        sub_button.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
        CGFloat width = sub_button.frame.size.width ;
        CGSize theSize;
        theSize = [strbuttonTitle sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(width, 40) lineBreakMode:UILineBreakModeWordWrap];
        
        CGFloat myLabelHeight = theSize.height;
        
        if(myLabelHeight>14){
            [sub_button setBackgroundImage:[UIImage imageNamed:@"btn_43_normal_double.png"] forState:UIControlStateNormal];
            [sub_button setBackgroundImage:[UIImage imageNamed:@"btn_43_selected_double.png"] forState:UIControlStateHighlighted];
            buttonHeight =41;
            [sub_button setFrame:CGRectMake(x, y, buttonWidth, buttonHeight)];
        }
        [sub_button addTarget:self action:@selector(menuButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        y = y + buttonHeight + 4;
        
        [viewPopOver addSubview:sub_button];
    }
    
    int totalHeight = 0.0;
    totalHeight = y;
    
    [viewPopOver setFrame:CGRectMake(viewPopOver.frame.origin.x, viewPopOver.frame.origin.y, POPOVER_VIEW_WIDTH,totalHeight)];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = viewPopOver.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:67.0/255 green:105.0/255 blue:142.0/255 alpha:1] CGColor], (id)[[UIColor colorWithRed:34.0/255 green:69.0/255 blue:108.0/255 alpha:1] CGColor], nil];
    
    gradient.cornerRadius = 4.0;
    
    [viewPopOver.layer insertSublayer:gradient atIndex:0];
    
    viewPopOver.layer.cornerRadius = 4.0;
    viewPopOver.clipsToBounds = YES;
}

-(void)setMenuPosition:(CGPoint)point{
    CGRect frame = [viewPopOver frame];
	frame.origin.x = point.x;
	frame.origin.y = point.y;
	[viewPopOver setFrame:frame];
}

-(void)setArrowPosition:(CustomMenuArrowAlignment)position{
    
    if(position == CustomMenuArrowAlignmentCenter){
        [imgArrow setFrame:CGRectMake(viewPopOver.frame.origin.x+(viewPopOver.frame.size.width/2-ARROW_WIDTH/2), viewPopOver.frame.origin.y-ARROW_HEIGHT, ARROW_WIDTH, ARROW_HEIGHT)];
    }
    else if(position == CustomMenuArrowAlignmentLeft){
        [imgArrow setFrame:CGRectMake(viewPopOver.frame.origin.x+20.0, viewPopOver.frame.origin.y-ARROW_HEIGHT, ARROW_WIDTH, ARROW_HEIGHT)];
        
    }else if(position == CustomMenuArrowAlignmentRight){
        [imgArrow setFrame:CGRectMake(viewPopOver.frame.origin.x+70.0, viewPopOver.frame.origin.y-ARROW_HEIGHT, ARROW_WIDTH, ARROW_HEIGHT)];
    }
}


-(IBAction)menuButtonTapped:(id)sender{
    UIButton *btn = sender;
    [delegate CustomMenuButtonTappedWithTitle:[btn titleForState:UIControlStateNormal]];
    [self removeFromSuperview];
}

@end
