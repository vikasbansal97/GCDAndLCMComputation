module GCD_LCM #(parameter SIZE = 8) (

    input clk,

    input rst_n,

    input [SIZE-1:0] data_in,

    input start,

    output reg [SIZE-1:0] gcd,

    output reg [SIZE*2:0] lcm,

    output reg done

);

 

    reg [SIZE-1:0] regA,regB,tempA,tempB,SUB;

    reg [SIZE*2:0] temp;

 

    ///////////////////////////////////////////////////////////////////// CONTROL PATH

    localparam START = 0, REGA = 1, REGB = 2, CALC = 3, DONE = 4;

    reg [2:0] state,next;

    always @(*) begin

        case(state)

            START: next = start?REGA:START;

            REGA: next = REGB;

            REGB: next = CALC;

            CALC: next = (tempA == tempB)?DONE:CALC;

            DONE: next = DONE;

            default: next = start;

        endcase

    end

    always @(posedge clk or negedge rst_n) begin

        if(!rst_n) state <= START;

        else state <= next;

    end

 

    //////////////////////////////////////////////////////////////////// DATA PATH

 

    always @(*) begin

        case(state)

        START: begin

            regA = 0;

            regB = 0;

            tempA = 0;

            tempB = 0;

            SUB = 0;

            temp = 0;

        end

        REGA: begin

            // regA = data_in;

            // tempA = regA;

        end

        REGB: begin

            // regB = data_in;

            // tempB = regB;

        end

        CALC: begin

            if(tempA > tempB) begin

                SUB = tempA - tempB;

                // tempA = SUB;

            end

            else if(tempB > tempA) begin

                SUB = tempB - tempA;

                // tempB = SUB;

            end

            else begin

                SUB = tempA;

                temp = regA*regB / SUB;

            end

        end

        DONE: begin

           

        end

        endcase

    end

 

    always @(posedge clk ) begin

        if(state == DONE) begin

           done <= 1'b1;

            gcd <= SUB;

            lcm <= temp;

        end

        else begin

            done <= 1'b0;

            gcd <= 0;

            lcm <= 0;

        end

    end

    always @(posedge clk) begin

        if(state == START) begin

            regA <= data_in;

            tempA <= data_in;

        end

        if(state == REGA) begin

            regB <= data_in;

            tempB <= data_in;

        end

        if(state == CALC) begin

            if(tempA > tempB) tempA <= SUB;

            else if(tempB > tempA) tempB <= SUB;

        end

    end

endmodule