----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:41:36 05/19/2014 
-- Design Name: 
-- Module Name:    sunar - Behavioral 
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sunar is
generic(width:integer:=173); 
port(a,b:in std_logic_vector(width-1 downto 0);
     c:out std_logic_vector(width-1 downto 0));
end sunar;

architecture Behavioral of sunar is
type int is array(0 to width-1) of integer;
signal p,q,r:std_logic_vector(width-1 downto 0);
function permutate (x:std_logic_vector)
return std_logic_vector is
variable e:std_logic_vector(width-1 downto 0);
variable k,j:integer;
variable temp:int;
begin
k:=1;
for i in 1 to x'length loop
k:=k mod ((2*x'length)+1);
if(k>x'length) then 
temp(i-1):=((2*x'length)+1)-k;
 else 
 temp(i-1):=k; 
 end if;
k:=2*k;
end loop;
for i in 1 to x'length loop
e(i-1):=x(temp(i-1)-1);
end loop;  

return e;


end permutate;
function sunarkoc(a,b:std_logic_vector)

return std_logic_vector is
variable c,d,e,f:std_logic_vector(width-1 downto 0):=(others=>'0');
begin
for i in 0 to a'length-2 loop
for j in 0 to a'length-i-2 loop

c(i) := (a(j) and b(j+i+1))xor(a(j+i+1)and b(j))xor c(i) ;
end loop;
end loop;
for k in 1 to a'length-1 loop
for l in 0 to k-1 loop
d(k):=(a(l) and b(k-l-1)) xor d(k);
end loop;
end loop;
for m in 0 to a'length-1 loop
for n in a'length-m-1 to a'length-1 loop
e(m):=(a(n) and b(2*a'length-2-(m+n))) xor e(m);
end loop;
end loop;
for u in 0 to a'length-1 loop
f(u):=(c(u) xor d(u)) xor e(u);
end loop;
return f;
end sunarkoc;
--function reverseperm (x:std_logic_vector)
--return std_logic_vector is
--variable t:std_logic_vector(2*x'length-1 downto 0):=(others=>'0');
--variable k,j:integer
--begin
begin
p<=permutate(a);
q<=permutate(b);
r<=sunarkoc(p,q);
c<=permutate(r);
end Behavioral;

