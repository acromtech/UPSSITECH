library ieee;
use ieee.std_logic_1164.all;

ENTITY montecharge IS
	PORT(
	    ET : IN STD_LOGIC_VECTOR (3 downto 0);
		 AP : IN STD_LOGIC_VECTOR (3 downto 0);
		 P4d : IN STD_LOGIC;
		 P3d : IN STD_LOGIC;
		 P2d : IN STD_LOGIC;
		 P1m : IN STD_LOGIC;
		 P2m : IN STD_LOGIC;
		 P3m : IN STD_LOGIC;
		 Horloge : IN STD_LOGIC;
		 PortOuverte : IN STD_LOGIC;
	    unites, dizaines        : OUT STD_LOGIC_VECTOR (6 downto 0);
		 montee : OUT STD_LOGIC;
		 descend : OUT STD_LOGIC
        );
END ENTITY;

ARCHITECTURE ar OF montecharge IS

constant zero   : STD_LOGIC_vector (6 downto 0) := "0000001";
constant un     : STD_LOGIC_vector (6 downto 0) := "1001111";
constant deux   : STD_LOGIC_vector (6 downto 0) := "0010010";
constant trois  : STD_LOGIC_vector (6 downto 0) := "0000110";
constant quatre : STD_LOGIC_vector (6 downto 0) := "1001100";
constant cinq   : STD_LOGIC_vector (6 downto 0) := "0100100";
constant six    : STD_LOGIC_vector (6 downto 0) := "0100000";
constant sept   : STD_LOGIC_vector (6 downto 0) := "0001111";
constant huit   : STD_LOGIC_vector (6 downto 0) := "0000000";
constant neuf   : STD_LOGIC_vector (6 downto 0) := "0000100";
constant erreur : STD_LOGIC_vector (6 downto 0) := "0110000";
constant eteint : STD_LOGIC_vector (6 downto 0) := "1111111";


Type Etat is (Etat0, Etat1, Etat2, Etat3, Etat4, Etat5,
Etat6, Etat7, Etat8, Etat9, Etat10, Etat11, Etat12, Etat13, Etat14, Etat15, Etat16, Etat17);
Signal EtatPresent, EtatSuivant : Etat;

BEGIN
--  Description du Bloc  F
	PROCESS (AP,ET,PortOuverte)
	  Begin
		Case EtatPresent IS
		-- traitement des etats 0,1,2,3
		  When Etat0 =>
			   IF PortOuverte='1' THEN EtatSuivant<=Etat1; 
            ELSE  EtatSuivant<=EtatPresent ;End IF;
		  When Etat1 =>
			   IF PortOuverte='0' THEN EtatSuivant<=Etat2; 
            ELSE  EtatSuivant<=EtatPresent ;End IF; 
 		  When Etat2 =>
			   IF AP(1)='1' THEN EtatSuivant<=Etat12;
				ELSIF AP(2)='1' THEN EtatSuivant<=Etat13;
				ELSIF AP(3)='1' THEN EtatSuivant<=Etat14;
            ELSE  EtatSuivant<=EtatPresent ;End IF; 
		  When Etat3 =>
			   IF PortOuverte='1' THEN EtatSuivant<=Etat4; 
            ELSE  EtatSuivant<=EtatPresent ;End IF;
		  When Etat4 =>
			   IF  PortOuverte='0' THEN EtatSuivant<=Etat5; 
            ELSE  EtatSuivant<=EtatPresent ;End IF; 
 		  When Etat5 =>
				IF AP(2)='1' THEN EtatSuivant<=Etat13;
				ELSIF AP(3)='1' THEN EtatSuivant<=Etat14;
				ELSIF AP(0)='1' THEN EtatSuivant<=Etat15;
            ELSE  EtatSuivant<=EtatPresent ;End IF;
		  When Etat6 =>
			   IF PortOuverte='1' THEN EtatSuivant<=Etat7; 
            ELSE  EtatSuivant<=EtatPresent ;End IF;
		  When Etat7 =>
			   IF PortOuverte='0' THEN EtatSuivant<=Etat8; 
            ELSE  EtatSuivant<=EtatPresent ;End IF; 
 		  When Etat8 =>
				IF AP(3)='1' THEN EtatSuivant<=Etat14;
				ELSIF AP(1)='1' THEN EtatSuivant<=Etat16;
				ELSIF AP(0)='1' THEN EtatSuivant<=Etat15;
            ELSE  EtatSuivant<=EtatPresent ;End IF;  
 		  When Etat9 =>
			   IF PortOuverte='1' THEN EtatSuivant<=Etat10; 
            ELSE  EtatSuivant<=EtatPresent ;End IF;
		  When Etat10 =>
			   IF  PortOuverte='0' THEN EtatSuivant<=Etat11; 
            ELSE  EtatSuivant<=EtatPresent ;End IF; 
 		  When Etat11 =>
				IF AP(2)='1' THEN EtatSuivant<=Etat17;
				ELSIF AP(1)='1' THEN EtatSuivant<=Etat16;
				ELSIF AP(0)='1' THEN EtatSuivant<=Etat15;
            ELSE  EtatSuivant<=EtatPresent ;End IF; 
 		  When Etat12 =>
			   IF ET(1)='1' THEN EtatSuivant<=Etat3; 
            ELSE  EtatSuivant<=EtatPresent ;End IF;
		  When Etat13 =>
			   IF ET(2)='1' THEN EtatSuivant<=Etat6; 
            ELSE  EtatSuivant<=EtatPresent ;End IF;
		  When Etat14 =>
			   IF ET(3)='1' THEN EtatSuivant<=Etat9; 
            ELSE  EtatSuivant<=EtatPresent ;End IF;
		  When Etat15 =>
			   IF ET(0)='1' THEN EtatSuivant<=Etat0; 
            ELSE  EtatSuivant<=EtatPresent ;End IF;
		  When Etat16 =>
			   IF ET(1)='1' THEN EtatSuivant<=Etat3; 
            ELSE  EtatSuivant<=EtatPresent ;End IF;
		  When Etat17 =>
			   IF ET(2)='1' THEN EtatSuivant<=Etat6; 
            ELSE  EtatSuivant<=EtatPresent ;End IF;
 		  End Case;  
      End Process;

-- Description du Bloc M
Process (Horloge) 
 Begin 
 IF ((Horloge'EVENT) And (Horloge = '1')) THEN
 EtatPresent <= EtatSuivant; End if; 
End Process; 

-- Description du Bloc G
 


   -- sorties pour pilotage des afficheurs de la carte
--with EtatPresent select
 --unites <= zero   when ...  | ... ,
	--       un     when ...  | ... ,
	  
	 --      neuf   when ...  | ... ,
	 --      erreur when others;
	 --      
--dizaines <= eteint when (EtatPresent <  ... ) else
        --    un     when (EtatPresent >  ... ) 
        --    else erreur;	       
	
montee <= '1' When (( EtatPresent = Etat12) Or (EtatPresent = Etat13) Or (EtatPresent = Etat14))
 ELSE '0';	
descend <= '1' When (( EtatPresent = Etat17) Or (EtatPresent = Etat16) Or (EtatPresent = Etat15))
 ELSE '0';
END ar ;

