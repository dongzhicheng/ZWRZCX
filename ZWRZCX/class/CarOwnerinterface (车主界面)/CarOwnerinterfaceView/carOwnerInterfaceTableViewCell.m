//
//  carOwnerInterfaceTableViewCell.m
//  ZWRZCX
//
//  Created by 董志成 on 16/6/13.
//  Copyright © 2016年 董志成. All rights reserved.
//

#import "carOwnerInterfaceTableViewCell.h"

@implementation carOwnerInterfaceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabe.numberOfLines = 0;
        self.detailTextLabel.text = @"travelInformationTableCell测试detailTextLabel换行";
        
    }
    
    return self;
}

@end
