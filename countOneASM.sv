module countOneASM #(parameter N=8) (
	
	input logic clk,
	input logic rst_n,
	input logic start,
	input logic [N-1:0] A,
	
	output logic [N-1:0] result,
	output logic done
	
);

typedef enum logic [2:0] {IDLE= 3'b001, COUNT= 3'b010, FINISH= 3'b100} statetype;

statetype next_state, curr_state;


logic load; //Load A into register during IDLE
logic shift;
logic empty;

logic start_sync; //Synchronize start signal to clk
logic restart;

logic count_clr; 
logic count_en; 
logic [N-1:0] count;

logic [N-1:0] shift_reg;

logic bitIsOne;
logic emptyReg;

//synchronize start signal to clk
always_ff @(posedge clk) 
begin 
	if (!rst_n)
		start_sync <= 0;
	else
		start_sync <= start;
end

//State Machine Register
always_ff @(posedge clk) 
begin 
	if (!rst_n)
		curr_state <= IDLE;
	else
		curr_state <= next_state;
end


//Next State Logic
always_comb
begin
	case (curr_state)
		IDLE: 
			if (start_sync)
				next_state = COUNT;
			else 
				next_state = IDLE;
		COUNT:
			if (empty)
				next_state = FINISH;
			else 
				next_state = COUNT;			
		FINISH:
			if (restart)
				next_state = IDLE;
			else 
				next_state = FINISH;				
	endcase
end

//Output Logic
always_comb
begin
//Initial values
	count_clr = 0;
	load = 0;
	
	count_en = 0;
	shift = 0;
	empty = 0;
	
	done = 0;
	restart = 0;
	case (curr_state)
		IDLE: 
			begin
				count_clr = 1;		
				load = 1;
			end	
		COUNT: 
			begin 
				count_en = bitIsOne;  // Enable count if bit 0 is a "1"
				shift = 1;
				empty = emptyReg; //Assert empty if all bits in shift_reg is 0;
			end
		FINISH:
			begin
				done = 1;
				if (start_sync == 0) //Restart state machine if start has deasserted
					restart = 1;
			end	
	endcase
end	

assign bitIsOne = (shift_reg[0] == 1'b1);
assign emptyReg = (shift_reg == 0);
	

//Shift Register to hold input A
always_ff @(posedge clk) 
begin 
	if (!rst_n)
		shift_reg <= 0;
	else
		if (load)
			shift_reg <= A;
		else
			if (shift)
				shift_reg <= {1'b0, shift_reg[N-1:1]};
end
	
	
//Result Counter
always_ff @(posedge clk) 
begin 
	if (!rst_n || count_clr)
		count <= 0;
	else
		if (count_en == 1)
			count <= count + 1;
		else
			count <= count;
end

assign result = count; 

endmodule