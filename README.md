# MSSegmentControl


[修改自PPiFlatSegmentedControl](https://github.com/pepibumur/PPiFlatSegmentedControl)

可自定义大部分segmentControl外观

**初始化**
	
	MSSegmentControl *segment = [[MSSegmentControl alloc] initWithFrame:CGRectMake(0, 0, 180, 40) items:[@"one", @"two", @"three"] selectionBlock:^(MSSegmentControl *segmentControl, NSUInteger curIndex, NSInteger preIndex) {
       // TODO
    }];
    
**设置属性**

	segment.color = [UIColor clearColor];
    segment.borderWidth = 1.0;
    segment.borderColor = [UIColor clearColor];
    segment.selectedColor = [UIColor clearColor];
    segment.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:15],
                             NSForegroundColorAttributeName:[UIColor clearColor]};
    segment.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:15];                                     NSForegroundColorAttributeName:[UIColor clearColor]};
