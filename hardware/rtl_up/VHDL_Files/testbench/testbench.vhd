-- testbench.vhd
-- Translated from testbench.v for MIPSfpgav2
--
-- 1 Apr 2017
--
-- Drive the mipsfpga_sys module for simulation testing

library ieee;
use ieee.std_logic_1164.all;
use work.mipsfpga_const.all;

entity testbench is
end testbench;


architecture behaviour of testbench is

    component mfp_sys is 
        port (
            SI_Reset_N      : in    std_logic;
            SI_ClkIn        : in    std_logic;
            SI_ColdReset_N  : in    std_logic;
            HADDR           : out   std_logic_vector(31 downto 0);
            HRDATA          : out   std_logic_vector(31 downto 0);
            HWDATA          : out   std_logic_vector(31 downto 0);
            HWRITE          : out   std_logic;
            HSIZE           : out   std_logic_vector(2 downto 0);
            EJ_TRST_N_probe : in    std_logic;
            EJ_TDI          : in    std_logic;
            EJ_TDO          : out   std_logic;
            EJ_TMS          : in    std_logic;
            EJ_TCK          : in    std_logic;
            EJ_DINT         : in    std_logic;
            IO_Switch       : in    std_logic_vector(MFP_N_SW-1 downto 0);
            IO_PB           : in    std_logic_vector(MFP_N_PB-1 downto 0);
            IO_LED          : out   std_logic_vector(MFP_N_LED-1 downto 0);
            UART_RX         : in    std_logic
        );
    end component mfp_sys;
    
    constant clk_period : time := 10 ns;


    signal SI_Reset_N, SI_ClkIn : std_logic;
    signal HADDR, HRDATA, HWDATA : std_logic_vector(31 downto 0);
    signal HWRITE : std_logic;
	signal HSIZE : std_logic_vector(2 downto 0);
    signal EJ_TRST_N_probe, EJ_TDI : std_logic; 
    signal EJ_TDO : std_logic;
    signal SI_ColdReset_N : std_logic;
    signal EJ_TMS, EJ_TCK, EJ_DINT : std_logic;
    signal IO_Switch : std_logic_vector(MFP_N_SW-1 downto 0);
    signal IO_PB : std_logic_vector(4 downto 0);
    signal IO_LED : std_logic_vector(MFP_N_LED-1 downto 0);
    signal UART_RX : std_logic;


begin


    mfp_sys_i: mfp_sys
        port map (
            SI_reset_N      => SI_reset_N,
            SI_ClkIn        => SI_ClkIn,
            HADDR           => HADDR,
            HRDATA          => HRDATA,
            HWDATA          => HWDATA,
            HWRITE          => HWRITE,
            HSIZE           => HSIZE,
            EJ_TRST_N_probe => EJ_TRST_N_probe,
            EJ_TDI          => EJ_TDI,
            EJ_TDO          => EJ_TDO,
            EJ_TMS          => EJ_TMS,
            EJ_TCK          => EJ_TCK,
            SI_ColdReset_N  => SI_ColdReset_N,
            EJ_DINT         => EJ_DINT ,
            IO_Switch       => IO_Switch,
            IO_PB           => IO_PB,
            IO_LED          => IO_LED,
            UART_RX         => UART_RX

        );


    clk_p : process
    begin
        SI_ClkIn <= '0';
        wait for clk_period/2;
        SI_ClkIn <= '1';
        wait for clk_period/2;
    end process;


    stim_p : process
    begin
        EJ_TRST_N_probe <= '0'; 
        EJ_TDI <= '0'; 
        EJ_TMS <= '0'; 
        EJ_TCK <= '0'; 
        EJ_DINT <= '0';
        UART_RX <= '1';
        SI_ColdReset_N <= '1';
        
        SI_Reset_N <= '0';
        wait for 100*clk_period;
        
        SI_Reset_N <= '1';
        wait for 200*clk_period;
        
        -- wait;
    end process;

end behaviour;
