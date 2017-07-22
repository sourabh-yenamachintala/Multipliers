----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:41:24 05/08/2014 
-- Design Name: 
-- Module Name:    karat - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all; 
use ieee.math_real.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;
--
-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity karat is
		Generic(width:integer:=8); 
    Port ( a : in  STD_LOGIC_VECTOR (width-1 downto 0);
           b : in  STD_LOGIC_VECTOR (width-1 downto 0);
           c : out  STD_LOGIC_VECTOR (2*width-1 downto 0));
end karat;

architecture Behavioral of karat is

	 
	 function mult(m,n:std_logic_vector)
		return std_logic_vector is
		
		variable x,y: std_logic_vector(m'length-1 downto 0):=(others=>'0');
		variable p1,p2,p0:std_logic_vector(2*x'length-1 downto 0):=(others=>'0');
		variable z0,z1,z2,res:std_logic_vector(2*x'length-1 downto 0):=(others=>'0');
		variable lh,rh,i:integer;
		variable temp_x,temp_y:std_logic_vector(natural(floor(real(x'length)/(2.0)))-1 downto 0):=(others=>'0');
		variable sum_x,sum_y:std_logic_vector(x'length-1 downto 0):=(others=>'0');
		variable zeroes:std_logic_vector(x'length-1 downto 0):=(others=>'0');
		variable reg: std_logic_vector(2*x'length-1 downto 0):=(others=>'0');
		variable add: std_logic_vector(x'length downto 0):=(others=>'0');
	begin
			report "Length:"& integer'image(x'length) severity Note;
			
			x:=m;
			y:=n;
		if x'length<16 then
			reg(y'length-1 downto 0):=y;
			for i in 1 to x'length loop
				if reg(0)='1' then
					add:=('0'&x)+('0'&reg(2*x'length-1 downto x'length));
					reg:=add&reg(x'length-1 downto 1);
				else
					reg:='0'&reg(2*x'length-1 downto 1);
				end if;
			end loop;
			
			return reg;
--			res:=x*y;
		else
			
			lh:=natural(floor(real(x'length)/(2.0)));
			rh:=natural(ceil (real(x'length)/(2.0)));
			temp_x:= x(x'length-1 downto rh);
			temp_y:= y(x'length-1 downto rh);
			
			if x'length mod 2=0 then
				z2(x'length-1 downto 0):=mult(temp_x,temp_y);
				z0(x'length-1 downto 0):= mult( x(rh-1 downto 0),y(rh-1 downto 0));
			else
				z2(x'length-1 downto 0):='0'& mult(temp_x,temp_y);					
				z0(x'length downto 0):= mult( x(rh-1 downto 0),y(rh-1 downto 0));
			end if;
			
			sum_x(x'length-1 downto 0):=(zeroes(x'length-1 downto lh)&temp_x)+ (zeroes(x'length-1 downto rh)&x( rh-1 downto 0));
			sum_y(x'length-1 downto 0):=(zeroes(x'length-1 downto lh)&temp_y)+ (zeroes(x'length-1 downto rh)&y( rh-1 downto 0));
			
			if sum_x(rh)='0' and sum_y(rh)='0' then
				if x'length mod 2= 0 then
					z1:=zeroes&mult(( temp_x+ x( rh-1 downto 0)), (temp_y+ y(rh-1 downto 0)))-z2-z0;
				else
					z1:=zeroes(x'length-2 downto 0)&mult(( '0'&temp_x+ x( rh-1 downto 0)), ('0'&temp_y+ y(rh-1 downto 0)))-z2-z0;
				end if;
			else
				z1(2*rh+1 downto 0):=mult(sum_x(rh downto 0),sum_y(rh downto 0));
				z1:=z1-z2-z0;
			end if;
			
			if x'length mod 2 =0 then
				p2(2*x'length-1 downto x'length):=z2(x'length-1 downto 0);
				p1(natural(ceil(real(3*x'length)/(2.0))) downto natural(ceil(real(x'length)/(2.0)))):=z1(x'length downto 0);
			else
				p2(2*x'length-1 downto x'length+1):=z2(x'length-2 downto 0);
				p1(natural(ceil(real(3*x'length)/(2.0))) downto natural(ceil(real(x'length)/(2.0)))):=z1(x'length downto 0);
			end if;
			
			res:=p2+p1+z0;
			
		end if;
		
		return res;
	end mult;
begin

	c<=mult(a,b);

end Behavioral;


