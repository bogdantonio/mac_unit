-- I manually wrote only the first 2 layers of the dadda multiplier, rest is ai, cause god damn ... 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dadda_16bit is
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           b : in STD_LOGIC_VECTOR (15 downto 0);
           result : out STD_LOGIC_VECTOR (31 downto 0));
end dadda_16bit;

architecture Behavioral of dadda_16bit is

component full_adder is
    Port ( x : in STD_LOGIC;
           y : in STD_LOGIC;
           cin : in STD_LOGIC;
           s : out STD_LOGIC;
           cout : out STD_LOGIC);
end component;

component half_adder is
    Port ( x : in STD_LOGIC;
           y : in STD_LOGIC;
           s : out STD_LOGIC;
           cout : out STD_LOGIC);
end component;

component kogge_stone_32bit is
    Port ( x : in STD_LOGIC_VECTOR (31 downto 0);
           y : in STD_LOGIC_VECTOR (31 downto 0);
           cin : in STD_LOGIC;
           s : out STD_LOGIC_VECTOR (31 downto 0);
           cout : out STD_LOGIC);
end component;

-- signals for storing the partial products
signal b0a: std_logic_vector(15 downto 0);
signal b1a: std_logic_vector(15 downto 0);
signal b2a: std_logic_vector(15 downto 0);
signal b3a: std_logic_vector(15 downto 0);
signal b4a: std_logic_vector(15 downto 0);
signal b5a: std_logic_vector(15 downto 0);
signal b6a: std_logic_vector(15 downto 0);
signal b7a: std_logic_vector(15 downto 0);
signal b8a: std_logic_vector(15 downto 0);
signal b9a: std_logic_vector(15 downto 0);
signal b10a: std_logic_vector(15 downto 0);
signal b11a: std_logic_vector(15 downto 0);
signal b12a: std_logic_vector(15 downto 0);
signal b13a: std_logic_vector(15 downto 0);
signal b14a: std_logic_vector(15 downto 0);
signal b15a: std_logic_vector(15 downto 0);

-- layer 1 has and fas outputs
signal ha11s, ha12s, ha13s, ha14s, fa11s, fa12s, fa13s, fa14s, fa15s, fa16s, fa17s, fa18s: std_logic;
signal ha11c, ha12c, ha13c, ha14c, fa11c, fa12c, fa13c, fa14c, fa15c, fa16c, fa17c, fa18c: std_logic;

-- layer 2 has and fas outputs
signal ha21s, ha22s, ha23s, ha24s, fa21s, fa22s, fa23s, fa24s, fa25s, fa26s, fa27s, fa28s, fa29s: std_logic;
signal fa210s, fa211s, fa212s, fa213s, fa214s, fa215s, fa216s, fa217s, fa218s, fa219s: std_logic;
signal fa220s, fa221s, fa222s, fa223s, fa224s, fa225s, fa226s, fa227s, fa228s, fa229s: std_logic;
signal fa230s, fa231s, fa232s, fa233s, fa234s, fa235s, fa236s, fa237s, fa238s, fa239s: std_logic;
signal fa240s: std_logic;
signal ha21c, ha22c, ha23c, ha24c, fa21c, fa22c, fa23c, fa24c, fa25c, fa26c, fa27c, fa28c, fa29c: std_logic; 
signal fa210c, fa211c, fa212c, fa213c, fa214c, fa215c, fa216c, fa217c, fa218c, fa219c: std_logic; 
signal fa220c, fa221c, fa222c, fa223c, fa224c, fa225c, fa226c, fa227c, fa228c, fa229c: std_logic;
signal fa230c, fa231c, fa232c, fa233c, fa234c, fa235c, fa236c, fa237c, fa238c, fa239c: std_logic;
signal fa240c: std_logic;

signal ha31s, ha32s, ha33s : std_logic;
signal ha31c, ha32c, ha33c : std_logic;
signal fa31s, fa32s, fa33s, fa34s, fa35s, fa36s, fa37s, fa38s, fa39s, fa310s : std_logic;
signal fa311s, fa312s, fa313s, fa314s, fa315s, fa316s, fa317s, fa318s, fa319s, fa320s : std_logic;
signal fa321s, fa322s, fa323s, fa324s, fa325s, fa326s, fa327s, fa328s, fa329s, fa330s : std_logic;
signal fa331s, fa332s, fa333s, fa334s, fa335s, fa336s, fa337s, fa338s, fa339s, fa340s : std_logic;
signal fa341s, fa342s, fa343s, fa344s, fa345s, fa346s, fa347s, fa348s, fa349s, fa350s : std_logic;
signal fa351s : std_logic;
signal fa31c, fa32c, fa33c, fa34c, fa35c, fa36c, fa37c, fa38c, fa39c, fa310c : std_logic;
signal fa311c, fa312c, fa313c, fa314c, fa315c, fa316c, fa317c, fa318c, fa319c, fa320c : std_logic;
signal fa321c, fa322c, fa323c, fa324c, fa325c, fa326c, fa327c, fa328c, fa329c, fa330c : std_logic;
signal fa331c, fa332c, fa333c, fa334c, fa335c, fa336c, fa337c, fa338c, fa339c, fa340c : std_logic;
signal fa341c, fa342c, fa343c, fa344c, fa345c, fa346c, fa347c, fa348c, fa349c, fa350c : std_logic;
signal fa351c : std_logic;

signal ha41s, ha42s : std_logic;
signal ha41c, ha42c : std_logic;
signal fa41s, fa42s, fa43s, fa44s, fa45s, fa46s, fa47s, fa48s, fa49s, fa410s : std_logic;
signal fa411s, fa412s, fa413s, fa414s, fa415s, fa416s, fa417s, fa418s, fa419s, fa420s : std_logic;
signal fa421s, fa422s, fa423s, fa424s, fa425s, fa426s, fa427s, fa428s, fa429s, fa430s : std_logic;
signal fa431s, fa432s, fa433s, fa434s, fa435s, fa436s, fa437s, fa438s, fa439s, fa440s : std_logic;
signal fa441s, fa442s, fa443s, fa444s : std_logic;
signal fa41c, fa42c, fa43c, fa44c, fa45c, fa46c, fa47c, fa48c, fa49c, fa410c : std_logic;
signal fa411c, fa412c, fa413c, fa414c, fa415c, fa416c, fa417c, fa418c, fa419c, fa420c : std_logic;
signal fa421c, fa422c, fa423c, fa424c, fa425c, fa426c, fa427c, fa428c, fa429c, fa430c : std_logic;
signal fa431c, fa432c, fa433c, fa434c, fa435c, fa436c, fa437c, fa438c, fa439c, fa440c : std_logic;
signal fa441c, fa442c, fa443c, fa444c : std_logic;

signal ha51s : std_logic;
signal ha51c : std_logic;
signal fa51s, fa52s, fa53s, fa54s, fa55s, fa56s, fa57s, fa58s, fa59s, fa510s : std_logic;
signal fa511s, fa512s, fa513s, fa514s, fa515s, fa516s, fa517s, fa518s, fa519s, fa520s : std_logic;
signal fa521s, fa522s, fa523s, fa524s, fa525s : std_logic;
signal fa51c, fa52c, fa53c, fa54c, fa55c, fa56c, fa57c, fa58c, fa59c, fa510c : std_logic;
signal fa511c, fa512c, fa513c, fa514c, fa515c, fa516c, fa517c, fa518c, fa519c, fa520c : std_logic;
signal fa521c, fa522c, fa523c, fa524c, fa525c : std_logic;

signal ha61s : std_logic;
signal ha61c : std_logic;
signal fa61s, fa62s, fa63s, fa64s, fa65s, fa66s, fa67s, fa68s, fa69s, fa610s : std_logic;
signal fa611s, fa612s, fa613s, fa614s, fa615s, fa616s, fa617s, fa618s, fa619s, fa620s : std_logic;
signal fa621s, fa622s, fa623s, fa624s, fa625s, fa626s, fa627s : std_logic;
signal fa61c, fa62c, fa63c, fa64c, fa65c, fa66c, fa67c, fa68c, fa69c, fa610c : std_logic;
signal fa611c, fa612c, fa613c, fa614c, fa615c, fa616c, fa617c, fa618c, fa619c, fa620c : std_logic;
signal fa621c, fa622c, fa623c, fa624c, fa625c, fa626c, fa627c : std_logic;

-- signals for the final addition layer
signal row_x, row_y : std_logic_vector(31 downto 0);
signal final_cout   : std_logic;

begin

partial_products_computation: for i in 0 to 15 generate
    b0a(i) <= b(0) and a(i);
    b1a(i) <= b(1) and a(i);
    b2a(i) <= b(2) and a(i);
    b3a(i) <= b(3) and a(i);
    b4a(i) <= b(4) and a(i);
    b5a(i) <= b(5) and a(i);
    b6a(i) <= b(6) and a(i);
    b7a(i) <= b(7) and a(i);
    b8a(i) <= b(8) and a(i);
    b9a(i) <= b(9) and a(i);
    b10a(i) <= b(10) and a(i);
    b11a(i) <= b(11) and a(i);
    b12a(i) <= b(12) and a(i);
    b13a(i) <= b(13) and a(i);
    b14a(i) <= b(14) and a(i);
    b15a(i) <= b(15) and a(i);
end generate partial_products_computation;

-- layer 1: goal height = 13
ha11: half_adder port map (x => b0a(13), y => b1a(12), s => ha11s, cout => ha11c);
ha12: half_adder port map (x => b3a(11), y => b4a(10), s => ha12s, cout => ha12c);
ha13: half_adder port map (x => b6a(9), y => b7a(8), s => ha13s, cout => ha13c);
ha14: half_adder port map (x => b7a(9), y => b8a(8), s => ha14s, cout => ha14c);

fa11: full_adder port map (x => b0a(14), y => b1a(13), cin => b2a(12), s => fa11s, cout => fa11c);
fa12: full_adder port map (x => b0a(15), y => b1a(14), cin => b2a(13), s => fa12s, cout => fa12c);
fa13: full_adder port map (x => b1a(15), y => b2a(14), cin => b3a(13), s => fa13s, cout => fa13c);
fa14: full_adder port map (x => b2a(15), y => b3a(14), cin => b4a(13), s => fa14s, cout => fa14c);
fa15: full_adder port map (x => b3a(15), y => b4a(14), cin => b5a(13), s => fa15s, cout => fa15c);
fa16: full_adder port map (x => b3a(12), y => b4a(11), cin => b5a(10), s => fa16s, cout => fa16c);
fa17: full_adder port map (x => b4a(12), y => b5a(11), cin => b6a(10), s => fa17s, cout => fa17c);
fa18: full_adder port map (x => b5a(12), y => b6a(11), cin => b7a(10), s => fa18s, cout => fa18c);

-- layer 2: goal height = 9
ha21: half_adder port map (x => b0a(9), y => b1a(8), s => ha21s, cout => ha21c);
ha22: half_adder port map (x => b3a(7), y => b4a(6), s => ha22s, cout => ha22c);
ha23: half_adder port map (x => b6a(5), y => b7a(4), s => ha23s, cout => ha23c);
ha24: half_adder port map (x => b9a(3), y => b10a(2), s => ha24s, cout => ha24c);

fa21: full_adder port map (x => b0a(10), y => b1a(9), cin => b2a(8), s => fa21s, cout => fa21c);
fa22: full_adder port map (x => b0a(11), y => b1a(10), cin => b2a(9), s => fa22s, cout => fa22c);
-- missed this adder
fa240: full_adder port map (x => b0a(12), y => b1a(11), cin => b2a(10), s => fa240s, cout => fa240c);

fa23: full_adder port map (x => ha11s, y => b2a(11), cin => b3a(10), s => fa23s, cout => fa23c);
fa24: full_adder port map (x => fa11s, y => ha11c, cin => ha12s, s => fa24s, cout => fa24c);
fa25: full_adder port map (x => fa12s, y => fa11c, cin => fa16s, s => fa25s, cout => fa25c);
fa26: full_adder port map (x => fa13s, y => fa12c, cin => fa17s, s => fa26s, cout => fa26c);
fa27: full_adder port map (x => fa14s, y => fa13c, cin => fa18s, s => fa27s, cout => fa27c);
fa28: full_adder port map (x => fa15s, y => fa14c, cin => b6a(12), s => fa28s, cout => fa28c);
fa29: full_adder port map (x => b4a(15), y => fa15c, cin => b5a(14), s => fa29s, cout => fa29c);
fa210: full_adder port map (x => b5a(15), y => b6a(14), cin => b7a(13), s => fa210s, cout => fa210c);
fa211: full_adder port map (x => b6a(15), y => b7a(14), cin => b8a(13), s => fa211s, cout => fa211c);
fa212: full_adder port map (x => b7a(15), y => b8a(14), cin => b9a(13), s => fa212s, cout => fa212c);
fa213: full_adder port map (x => b3a(8), y => b4a(7), cin => b5a(6), s => fa213s, cout => fa213c);
fa214: full_adder port map (x => b3a(9), y => b4a(8), cin => b5a(7), s => fa214s, cout => fa214c);
fa215: full_adder port map (x => b4a(9), y => b5a(8), cin => b6a(7), s => fa215s, cout => fa215c);
fa216: full_adder port map (x => b5a(9), y => b6a(8), cin => b7a(7), s => fa216s, cout => fa216c);
fa217: full_adder port map (x => ha12c, y => ha13s, cin => b8a(7), s => fa217s, cout => fa217c);
fa218: full_adder port map (x => fa16c, y => ha14s, cin => ha13c, s => fa218s, cout => fa218c);
fa219: full_adder port map (x => fa17c, y => b8a(9), cin => ha14c, s => fa219s, cout => fa219c);
fa220: full_adder port map (x => fa18c, y => b7a(11), cin => b8a(10), s => fa220s, cout => fa220c);
fa221: full_adder port map (x => b6a(13), y => b7a(12), cin => b8a(11), s => fa221s, cout => fa221c);
fa222: full_adder port map (x => b8a(12), y => b9a(11), cin => b10a(10), s => fa222s, cout => fa222c);
fa223: full_adder port map (x => b9a(12), y => b10a(11), cin => b11a(10), s => fa223s, cout => fa223c);
fa224: full_adder port map (x => b6a(6), y => b7a(5), cin => b8a(4), s => fa224s, cout => fa224c);
fa225: full_adder port map (x => b7a(6), y => b8a(5), cin => b9a(4), s => fa225s, cout => fa225c);
fa226: full_adder port map (x => b8a(6), y => b9a(5), cin => b10a(4), s => fa226s, cout => fa226c);
fa227: full_adder port map (x => b9a(6), y => b10a(5), cin => b11a(4), s => fa227s, cout => fa227c);
fa228: full_adder port map (x => b9a(7), y => b10a(6), cin => b11a(5), s => fa228s, cout => fa228c);
fa229: full_adder port map (x => b9a(8), y => b10a(7), cin => b11a(6), s => fa229s, cout => fa229c);
fa230: full_adder port map (x => b9a(9), y => b10a(8), cin => b11a(7), s => fa230s, cout => fa230c);
fa231: full_adder port map (x => b9a(10), y => b10a(9), cin => b11a(8), s => fa231s, cout => fa231c);
fa232: full_adder port map (x => b11a(9), y => b12a(8), cin => b13a(7), s => fa232s, cout => fa232c);
fa233: full_adder port map (x => b10a(3), y => b11a(2), cin => b12a(1), s => fa233s, cout => fa233c);
fa234: full_adder port map (x => b11a(3), y => b12a(2), cin => b13a(1), s => fa234s, cout => fa234c);
fa235: full_adder port map (x => b12a(3), y => b13a(2), cin => b14a(1), s => fa235s, cout => fa235c);
fa236: full_adder port map (x => b12a(4), y => b13a(3), cin => b14a(2), s => fa236s, cout => fa236c);
fa237: full_adder port map (x => b12a(5), y => b13a(4), cin => b14a(3), s => fa237s, cout => fa237c);
fa238: full_adder port map (x => b12a(6), y => b13a(5), cin => b14a(4), s => fa238s, cout => fa238c);
fa239: full_adder port map (x => b12a(7), y => b13a(6), cin => b14a(5), s => fa239s, cout => fa239c);

-- Layer 3: target height = 6
ha31: half_adder port map (x => b0a(6), y => b1a(5), s => ha31s, cout => ha31c);
fa31: full_adder port map (x => b0a(7), y => b1a(6), cin => b2a(5), s => fa31s, cout => fa31c);
ha32: half_adder port map (x => b3a(4), y => b4a(3), s => ha32s, cout => ha32c);
fa32: full_adder port map (x => b0a(8), y => b1a(7), cin => b2a(6), s => fa32s, cout => fa32c);
fa33: full_adder port map (x => b3a(5), y => b4a(4), cin => b5a(3), s => fa33s, cout => fa33c);
ha33: half_adder port map (x => b6a(2), y => b7a(1), s => ha33s, cout => ha33c);
fa34: full_adder port map (x => b2a(7), y => b3a(6), cin => b4a(5), s => fa34s, cout => fa34c);
fa35: full_adder port map (x => b5a(4), y => b6a(3), cin => b7a(2), s => fa35s, cout => fa35c);
fa36: full_adder port map (x => b8a(1), y => b9a(0), cin => ha21s, s => fa36s, cout => fa36c);
fa37: full_adder port map (x => b10a(0), y => b5a(5), cin => b6a(4), s => fa37s, cout => fa37c);
fa38: full_adder port map (x => b7a(3), y => b8a(2), cin => b9a(1), s => fa38s, cout => fa38c);
fa39: full_adder port map (x => fa21s, y => ha21c, cin => ha22s, s => fa39s, cout => fa39c);
fa310: full_adder port map (x => b10a(1), y => b11a(0), cin => b8a(3), s => fa310s, cout => fa310c);
fa311: full_adder port map (x => b9a(2), y => fa213s, cin => fa21c, s => fa311s, cout => fa311c);
fa312: full_adder port map (x => fa22s, y => ha22c, cin => ha23s, s => fa312s, cout => fa312c);
fa313: full_adder port map (x => b11a(1), y => b12a(0), cin => fa213c, s => fa313s, cout => fa313c);
fa314: full_adder port map (x => fa214s, y => fa224s, cin => fa22c, s => fa314s, cout => fa314c);
fa315: full_adder port map (x => fa240s, y => ha23c, cin => ha24s, s => fa315s, cout => fa315c);
fa316: full_adder port map (x => b13a(0), y => fa214c, cin => fa215s, s => fa316s, cout => fa316c);
fa317: full_adder port map (x => fa224c, y => fa225s, cin => fa233s, s => fa317s, cout => fa317c);
fa318: full_adder port map (x => fa23s, y => fa240c, cin => ha24c, s => fa318s, cout => fa318c);
fa319: full_adder port map (x => b14a(0), y => fa215c, cin => fa216s, s => fa319s, cout => fa319c);
fa320: full_adder port map (x => fa225c, y => fa226s, cin => fa233c, s => fa320s, cout => fa320c);
fa321: full_adder port map (x => fa234s, y => fa23c, cin => fa24s, s => fa321s, cout => fa321c);
fa322: full_adder port map (x => b15a(0), y => fa216c, cin => fa217s, s => fa322s, cout => fa322c);
fa323: full_adder port map (x => fa226c, y => fa227s, cin => fa234c, s => fa323s, cout => fa323c);
fa324: full_adder port map (x => fa235s, y => fa24c, cin => fa25s, s => fa324s, cout => fa324c);
fa325: full_adder port map (x => b15a(1), y => fa217c, cin => fa218s, s => fa325s, cout => fa325c);
fa326: full_adder port map (x => fa227c, y => fa228s, cin => fa235c, s => fa326s, cout => fa326c);
fa327: full_adder port map (x => fa236s, y => fa25c, cin => fa26s, s => fa327s, cout => fa327c);
fa328: full_adder port map (x => b15a(2), y => fa218c, cin => fa219s, s => fa328s, cout => fa328c);
fa329: full_adder port map (x => fa228c, y => fa229s, cin => fa236c, s => fa329s, cout => fa329c);
fa330: full_adder port map (x => fa237s, y => fa26c, cin => fa27s, s => fa330s, cout => fa330c);
fa331: full_adder port map (x => b15a(3), y => fa219c, cin => fa220s, s => fa331s, cout => fa331c);
fa332: full_adder port map (x => fa229c, y => fa230s, cin => fa237c, s => fa332s, cout => fa332c);
fa333: full_adder port map (x => fa238s, y => fa27c, cin => fa28s, s => fa333s, cout => fa333c);
fa334: full_adder port map (x => b15a(4), y => fa220c, cin => fa221s, s => fa334s, cout => fa334c);
fa335: full_adder port map (x => fa230c, y => fa231s, cin => fa238c, s => fa335s, cout => fa335c);
fa336: full_adder port map (x => fa239s, y => fa28c, cin => fa29s, s => fa336s, cout => fa336c);
fa337: full_adder port map (x => b14a(6), y => b15a(5), cin => fa210s, s => fa337s, cout => fa337c);
fa338: full_adder port map (x => fa221c, y => fa222s, cin => fa231c, s => fa338s, cout => fa338c);
fa339: full_adder port map (x => fa232s, y => fa239c, cin => fa29c, s => fa339s, cout => fa339c);
fa340: full_adder port map (x => b12a(9), y => b13a(8), cin => b14a(7), s => fa340s, cout => fa340c);
fa341: full_adder port map (x => b15a(6), y => fa210c, cin => fa211s, s => fa341s, cout => fa341c);
fa342: full_adder port map (x => fa222c, y => fa223s, cin => fa232c, s => fa342s, cout => fa342c);
fa343: full_adder port map (x => b10a(12), y => b11a(11), cin => b12a(10), s => fa343s, cout => fa343c);
fa344: full_adder port map (x => b13a(9), y => b14a(8), cin => b15a(7), s => fa344s, cout => fa344c);
fa345: full_adder port map (x => fa211c, y => fa212s, cin => fa223c, s => fa345s, cout => fa345c);
fa346: full_adder port map (x => b10a(13), y => b11a(12), cin => b12a(11), s => fa346s, cout => fa346c);
fa347: full_adder port map (x => b13a(10), y => b14a(9), cin => b15a(8), s => fa347s, cout => fa347c);
fa348: full_adder port map (x => b8a(15), y => b9a(14), cin => fa212c, s => fa348s, cout => fa348c);
fa349: full_adder port map (x => b10a(14), y => b11a(13), cin => b12a(12), s => fa349s, cout => fa349c);
fa350: full_adder port map (x => b13a(11), y => b14a(10), cin => b15a(9), s => fa350s, cout => fa350c);
fa351: full_adder port map (x => b10a(15), y => b11a(14), cin => b12a(13), s => fa351s, cout => fa351c);

-- Layer 4: target height = 4
ha41: half_adder port map (x => b0a(4), y => b1a(3), s => ha41s, cout => ha41c);
fa41: full_adder port map (x => b0a(5), y => b1a(4), cin => b2a(3), s => fa41s, cout => fa41c);
ha42: half_adder port map (x => b3a(2), y => b4a(1), s => ha42s, cout => ha42c);
fa42: full_adder port map (x => b2a(4), y => b3a(3), cin => b4a(2), s => fa42s, cout => fa42c);
fa43: full_adder port map (x => b5a(1), y => b6a(0), cin => ha31s, s => fa43s, cout => fa43c);
fa44: full_adder port map (x => b5a(2), y => b6a(1), cin => b7a(0), s => fa44s, cout => fa44c);
fa45: full_adder port map (x => fa31s, y => ha31c, cin => ha32s, s => fa45s, cout => fa45c);
fa46: full_adder port map (x => b8a(0), y => fa31c, cin => fa32s, s => fa46s, cout => fa46c);
fa47: full_adder port map (x => fa33s, y => ha32c, cin => ha33s, s => fa47s, cout => fa47c);
fa48: full_adder port map (x => fa32c, y => fa33c, cin => fa34s, s => fa48s, cout => fa48c);
fa49: full_adder port map (x => fa35s, y => fa36s, cin => ha33c, s => fa49s, cout => fa49c);
fa410: full_adder port map (x => fa34c, y => fa35c, cin => fa36c, s => fa410s, cout => fa410c);
fa411: full_adder port map (x => fa37s, y => fa38s, cin => fa39s, s => fa411s, cout => fa411c);
fa412: full_adder port map (x => fa310s, y => fa311s, cin => fa312s, s => fa412s, cout => fa412c);
fa413: full_adder port map (x => fa37c, y => fa38c, cin => fa39c, s => fa413s, cout => fa413c);
fa414: full_adder port map (x => fa310c, y => fa311c, cin => fa312c, s => fa414s, cout => fa414c);
fa415: full_adder port map (x => fa313s, y => fa314s, cin => fa315s, s => fa415s, cout => fa415c);
fa416: full_adder port map (x => fa313c, y => fa314c, cin => fa315c, s => fa416s, cout => fa416c);
fa417: full_adder port map (x => fa316s, y => fa317s, cin => fa318s, s => fa417s, cout => fa417c);
fa418: full_adder port map (x => fa316c, y => fa317c, cin => fa318c, s => fa418s, cout => fa418c);
fa419: full_adder port map (x => fa319s, y => fa320s, cin => fa321s, s => fa419s, cout => fa419c);
fa420: full_adder port map (x => fa319c, y => fa320c, cin => fa321c, s => fa420s, cout => fa420c);
fa421: full_adder port map (x => fa322s, y => fa323s, cin => fa324s, s => fa421s, cout => fa421c);
fa422: full_adder port map (x => fa322c, y => fa323c, cin => fa324c, s => fa422s, cout => fa422c);
fa423: full_adder port map (x => fa325s, y => fa326s, cin => fa327s, s => fa423s, cout => fa423c);
fa424: full_adder port map (x => fa325c, y => fa326c, cin => fa327c, s => fa424s, cout => fa424c);
fa425: full_adder port map (x => fa328s, y => fa329s, cin => fa330s, s => fa425s, cout => fa425c);
fa426: full_adder port map (x => fa328c, y => fa329c, cin => fa330c, s => fa426s, cout => fa426c);
fa427: full_adder port map (x => fa331s, y => fa332s, cin => fa333s, s => fa427s, cout => fa427c);
fa428: full_adder port map (x => fa331c, y => fa332c, cin => fa333c, s => fa428s, cout => fa428c);
fa429: full_adder port map (x => fa334s, y => fa335s, cin => fa336s, s => fa429s, cout => fa429c);
fa430: full_adder port map (x => fa334c, y => fa335c, cin => fa336c, s => fa430s, cout => fa430c);
fa431: full_adder port map (x => fa337s, y => fa338s, cin => fa339s, s => fa431s, cout => fa431c);
fa432: full_adder port map (x => fa337c, y => fa338c, cin => fa339c, s => fa432s, cout => fa432c);
fa433: full_adder port map (x => fa340s, y => fa341s, cin => fa342s, s => fa433s, cout => fa433c);
fa434: full_adder port map (x => fa340c, y => fa341c, cin => fa342c, s => fa434s, cout => fa434c);
fa435: full_adder port map (x => fa343s, y => fa344s, cin => fa345s, s => fa435s, cout => fa435c);
fa436: full_adder port map (x => fa343c, y => fa344c, cin => fa345c, s => fa436s, cout => fa436c);
fa437: full_adder port map (x => fa346s, y => fa347s, cin => fa348s, s => fa437s, cout => fa437c);
fa438: full_adder port map (x => b9a(15), y => fa346c, cin => fa347c, s => fa438s, cout => fa438c);
fa439: full_adder port map (x => fa348c, y => fa349s, cin => fa350s, s => fa439s, cout => fa439c);
fa440: full_adder port map (x => b13a(12), y => b14a(11), cin => b15a(10), s => fa440s, cout => fa440c);
fa441: full_adder port map (x => fa349c, y => fa350c, cin => fa351s, s => fa441s, cout => fa441c);
fa442: full_adder port map (x => b11a(15), y => b12a(14), cin => b13a(13), s => fa442s, cout => fa442c);
fa443: full_adder port map (x => b14a(12), y => b15a(11), cin => fa351c, s => fa443s, cout => fa443c);
fa444: full_adder port map (x => b12a(15), y => b13a(14), cin => b14a(13), s => fa444s, cout => fa444c);

-- Layer 5: target height = 3
ha51: half_adder port map (x => b0a(3), y => b1a(2), s => ha51s, cout => ha51c);
fa51: full_adder port map (x => b2a(2), y => b3a(1), cin => b4a(0), s => fa51s, cout => fa51c);
fa52: full_adder port map (x => b5a(0), y => fa41s, cin => ha41c, s => fa52s, cout => fa52c);
fa53: full_adder port map (x => fa41c, y => fa42s, cin => fa43s, s => fa53s, cout => fa53c);
fa54: full_adder port map (x => fa42c, y => fa43c, cin => fa44s, s => fa54s, cout => fa54c);
fa55: full_adder port map (x => fa44c, y => fa45c, cin => fa46s, s => fa55s, cout => fa55c);
fa56: full_adder port map (x => fa46c, y => fa47c, cin => fa48s, s => fa56s, cout => fa56c);
fa57: full_adder port map (x => fa410s, y => fa411s, cin => fa48c, s => fa57s, cout => fa57c);
fa58: full_adder port map (x => fa410c, y => fa411c, cin => fa412s, s => fa58s, cout => fa58c);
fa59: full_adder port map (x => fa412c, y => fa413c, cin => fa414s, s => fa59s, cout => fa59c);
fa510: full_adder port map (x => fa414c, y => fa415c, cin => fa416s, s => fa510s, cout => fa510c);
fa511: full_adder port map (x => fa416c, y => fa417c, cin => fa418s, s => fa511s, cout => fa511c);
fa512: full_adder port map (x => fa418c, y => fa419c, cin => fa420s, s => fa512s, cout => fa512c);
fa513: full_adder port map (x => fa420c, y => fa421c, cin => fa422s, s => fa513s, cout => fa513c);
fa514: full_adder port map (x => fa422c, y => fa423c, cin => fa424s, s => fa514s, cout => fa514c);
fa515: full_adder port map (x => fa424c, y => fa425c, cin => fa426s, s => fa515s, cout => fa515c);
fa516: full_adder port map (x => fa426c, y => fa427c, cin => fa428s, s => fa516s, cout => fa516c);
fa517: full_adder port map (x => fa428c, y => fa429c, cin => fa430s, s => fa517s, cout => fa517c);
fa518: full_adder port map (x => fa430c, y => fa431c, cin => fa432s, s => fa518s, cout => fa518c);
fa519: full_adder port map (x => fa432c, y => fa433c, cin => fa434s, s => fa519s, cout => fa519c);
fa520: full_adder port map (x => fa434c, y => fa435c, cin => fa436s, s => fa520s, cout => fa520c);
fa521: full_adder port map (x => fa436c, y => fa437c, cin => fa438s, s => fa521s, cout => fa521c);
fa522: full_adder port map (x => fa438c, y => fa439c, cin => fa440s, s => fa522s, cout => fa522c);
fa523: full_adder port map (x => fa440c, y => fa441c, cin => fa442s, s => fa523s, cout => fa523c);
fa524: full_adder port map (x => b15a(12), y => fa442c, cin => fa443c, s => fa524s, cout => fa524c);
fa525: full_adder port map (x => b13a(15), y => b14a(14), cin => b15a(13), s => fa525s, cout => fa525c);

-- Layer 6: target height = 2
ha61: half_adder port map (x => b0a(2), y => b1a(1), s => ha61s, cout => ha61c);
fa61: full_adder port map (x => b2a(1), y => b3a(0), cin => ha51s, s => fa61s, cout => fa61c);
fa62: full_adder port map (x => fa51s, y => ha41s, cin => ha51c, s => fa62s, cout => fa62c);
fa63: full_adder port map (x => fa51c, y => fa52s, cin => ha42s, s => fa63s, cout => fa63c);
fa64: full_adder port map (x => fa52c, y => fa53s, cin => ha42c, s => fa64s, cout => fa64c);
fa65: full_adder port map (x => fa45s, y => fa53c, cin => fa54s, s => fa65s, cout => fa65c);
fa66: full_adder port map (x => fa47s, y => fa54c, cin => fa55s, s => fa66s, cout => fa66c);
fa67: full_adder port map (x => fa49s, y => fa55c, cin => fa56s, s => fa67s, cout => fa67c);
fa68: full_adder port map (x => fa49c, y => fa56c, cin => fa57s, s => fa68s, cout => fa68c);
fa69: full_adder port map (x => fa413s, y => fa57c, cin => fa58s, s => fa69s, cout => fa69c);
fa610: full_adder port map (x => fa415s, y => fa58c, cin => fa59s, s => fa610s, cout => fa610c);
fa611: full_adder port map (x => fa417s, y => fa510s, cin => fa59c, s => fa611s, cout => fa611c);
fa612: full_adder port map (x => fa419s, y => fa510c, cin => fa511s, s => fa612s, cout => fa612c);
fa613: full_adder port map (x => fa421s, y => fa511c, cin => fa512s, s => fa613s, cout => fa613c);
fa614: full_adder port map (x => fa423s, y => fa512c, cin => fa513s, s => fa614s, cout => fa614c);
fa615: full_adder port map (x => fa425s, y => fa513c, cin => fa514s, s => fa615s, cout => fa615c);
fa616: full_adder port map (x => fa427s, y => fa514c, cin => fa515s, s => fa616s, cout => fa616c);
fa617: full_adder port map (x => fa429s, y => fa515c, cin => fa516s, s => fa617s, cout => fa617c);
fa618: full_adder port map (x => fa431s, y => fa516c, cin => fa517s, s => fa618s, cout => fa618c);
fa619: full_adder port map (x => fa433s, y => fa517c, cin => fa518s, s => fa619s, cout => fa619c);
fa620: full_adder port map (x => fa435s, y => fa518c, cin => fa519s, s => fa620s, cout => fa620c);
fa621: full_adder port map (x => fa437s, y => fa519c, cin => fa520s, s => fa621s, cout => fa621c);
fa622: full_adder port map (x => fa439s, y => fa520c, cin => fa521s, s => fa622s, cout => fa622c);
fa623: full_adder port map (x => fa441s, y => fa521c, cin => fa522s, s => fa623s, cout => fa623c);
fa624: full_adder port map (x => fa443s, y => fa522c, cin => fa523s, s => fa624s, cout => fa624c);
fa625: full_adder port map (x => fa444s, y => fa523c, cin => fa524s, s => fa625s, cout => fa625c);
fa626: full_adder port map (x => fa444c, y => fa524c, cin => fa525s, s => fa626s, cout => fa626c);
fa627: full_adder port map (x => b14a(15), y => b15a(14), cin => fa525c, s => fa627s, cout => fa627c);

-- operands of the final addition layer
row_x(0) <= b0a(0);
row_y(0) <= '0';
row_x(1) <= b0a(1);
row_y(1) <= b1a(0);
row_x(2) <= b2a(0);
row_y(2) <= ha61s;
row_x(3) <= fa61s;
row_y(3) <= ha61c;
row_x(4) <= fa61c;
row_y(4) <= fa62s;
row_x(5) <= fa62c;
row_y(5) <= fa63s;
row_x(6) <= fa63c;
row_y(6) <= fa64s;
row_x(7) <= fa64c;
row_y(7) <= fa65s;
row_x(8) <= fa65c;
row_y(8) <= fa66s;
row_x(9) <= fa66c;
row_y(9) <= fa67s;
row_x(10) <= fa67c;
row_y(10) <= fa68s;
row_x(11) <= fa68c;
row_y(11) <= fa69s;
row_x(12) <= fa610s;
row_y(12) <= fa69c;
row_x(13) <= fa610c;
row_y(13) <= fa611s;
row_x(14) <= fa611c;
row_y(14) <= fa612s;
row_x(15) <= fa612c;
row_y(15) <= fa613s;
row_x(16) <= fa613c;
row_y(16) <= fa614s;
row_x(17) <= fa614c;
row_y(17) <= fa615s;
row_x(18) <= fa615c;
row_y(18) <= fa616s;
row_x(19) <= fa616c;
row_y(19) <= fa617s;
row_x(20) <= fa617c;
row_y(20) <= fa618s;
row_x(21) <= fa618c;
row_y(21) <= fa619s;
row_x(22) <= fa619c;
row_y(22) <= fa620s;
row_x(23) <= fa620c;
row_y(23) <= fa621s;
row_x(24) <= fa621c;
row_y(24) <= fa622s;
row_x(25) <= fa622c;
row_y(25) <= fa623s;
row_x(26) <= fa623c;
row_y(26) <= fa624s;
row_x(27) <= fa624c;
row_y(27) <= fa625s;
row_x(28) <= fa625c;
row_y(28) <= fa626s;
row_x(29) <= fa626c;
row_y(29) <= fa627s;
row_x(30) <= b15a(15);
row_y(30) <= fa627c;
row_x(31) <= '0';
row_y(31) <= '0';

final_adder: kogge_stone_32bit port map (x => row_x, y => row_y, cin => '0', s => result, cout => final_cout);

end Behavioral;
