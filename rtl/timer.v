module timer(
	input wire clk,
	input wire rst_n,
	input wire [31:0] divFactor,
	output reg usec_clk,
	output reg usec_pulse,
	output reg msec_clk,
	output reg msec_pulse,
	output reg sec_clk,
	output reg sec_pulse
);

always @(posedge clk or negedge rst_n)
begin
	if(!rst_n) begin
		usec_clk<=0;
		msec_clk<=0;
		 sec_clk<=0;
		usec_pulse<=0;
		msec_pulse<=0;
		 sec_pulse<=0;
		 counter<=0;
		 msec_count<=0;
		 usec_count<=0;
		  sec_count<=0;
	end
	else begin
		usec_pulse<=0;
		msec_pulse<=0;
		 sec_pulse<=0;
		counter<=counter+h32'h01;
		if(counter==divFactor) begin
			usec_pulse<=1;
			usec_clk<=~usec_clk;
			usec_count<=usec_count+10'h01;
			counter<=0;
		end
		if(usec_count==1000)begin
			usec_count<=0;
			msec_pulse<=1;
			msec_clk<=~msec_clk;
			msec_count<=msec_count+1;
		end
		if(msec_count==1000)begin
			msec_count<=0;
			 sec_pulse<=1;
			 sec_clk<=~msec_clk;
		end
	end
end
endmodule
