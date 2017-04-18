#ifndef __ASM_EXPRESSION_H__
#define __ASM_EXPRESSION_H__

#define reg(x) DOLLAR >> x

#define R1_R2_R3 reg(R1) >> COMMA >> reg(R2) >> COMMA >> reg(R3)
#define R1_R2_V3 reg(R1) >> COMMA >> reg(R2) >> COMMA >> VAL3
// #define R1_V2_V3 reg(R1) >> COMMA >> VAL2 >> COMMA >> VAL3
#define R1_IM    reg(R1) >> COMMA >> IMDT
#define R1_R2    reg(R1) >> COMMA >> reg(R2)
#define R2_R3    reg(R2) >> COMMA >> reg(R3)

#endif
