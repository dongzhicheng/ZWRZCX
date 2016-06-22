//
//  travelInformationTableCell.m
//  ZWRZCX
//
//  Created by 董志成 on 16/6/3.
//  Copyright © 2016年 董志成. All rights reserved.
//

#import "travelInformationTableCell.h"


@implementation travelInformationTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabe.numberOfLines = 0;
        self.textLabe.text = @"travelInformationTableCell测试detailTextLabel换行";
        
    }
    
    return self;
}


@end
