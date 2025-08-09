import torch
import torch.nn as nn

class DepthwiseSeparableConv1d(nn.Module):
    def __init__(self, in_ch, out_ch, kernel_size, stride=1, padding=0):
        super().__init__()
        self.depthwise = nn.Conv1d(in_ch, in_ch, kernel_size, stride, padding, groups=in_ch)
        self.pointwise = nn.Conv1d(in_ch, out_ch, 1)
        self.bn = nn.BatchNorm1d(out_ch)
        self.relu = nn.ReLU()

    def forward(self, x):
        out = self.depthwise(x)
        out = self.pointwise(out)
        out = self.bn(out)
        return self.relu(out)
    
    
class QuartzNetSmall(nn.Module):
    def __init__(self, vocab_size):
        super().__init__()
        self.conv1 = nn.Conv1d(40, 128, kernel_size=33, stride=2, padding=16)
        self.bn1 = nn.BatchNorm1d(128)
        self.relu = nn.ReLU()

        # 3 Blocks × 5 sub-blocks
        blocks = []
        for _ in range(3):
            sub_blocks = []
            for _ in range(5):
                sub_blocks.append(DepthwiseSeparableConv1d(128, 128, kernel_size=33, padding=16))
            blocks.append(nn.Sequential(*sub_blocks))
        self.blocks = nn.Sequential(*blocks)

        self.conv_out = nn.Conv1d(128, vocab_size, kernel_size=1)

    def forward(self, x):
        x = self.relu(self.bn1(self.conv1(x)))
        x = self.blocks(x)
        x = self.conv_out(x)
        return x
