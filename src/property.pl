/* FACTS */

/* Identity */
/* property(Name) */
/* Menunjukkan apabila Name adalah property atau non-property */
property(A1).
property(A2).
property(A3).
property(B1).
property(B2).
property(B3).
property(C1).
property(C2).
property(C3).
property(D1).
property(D2).
property(D3).
property(E1).
property(E2).
property(E3).
property(F1).
property(F2).
property(F3).
property(G1).
property(G2).
property(G3).
property(H1).
property(H2).

/* Classifier */
/* Level dari property */
/* levelProp(Level, Prop) */
:- dynamic(levelProp/2).
levelProp(A1, 0).
levelProp(A2, 0).
levelProp(A3, 0).
levelProp(B1, 0).
levelProp(B2, 0).
levelProp(B3, 0).
levelProp(C1, 0).
levelProp(C2, 0).
levelProp(C3, 0).
levelProp(D1, 0).
levelProp(D2, 0).
levelProp(D3, 0).
levelProp(E1, 0).
levelProp(E2, 0).
levelProp(E3, 0).
levelProp(F1, 0).
levelProp(F2, 0).
levelProp(F3, 0).
levelProp(G1, 0).
levelProp(G2, 0).
levelProp(G3, 0).
levelProp(H1, 0).
levelProp(H2, 0).

/* Property Information */

/* propertyName(Name, P) */
/* Name adalah nama properti P */

propertyName("Labtek V", A1).
propertyName("Labtek VIII", A2).
propertyName("Labtek Biru", A3).
propertyName("Gedung PLN", B1).
propertyName("Gedung TVST", B2).
propertyName("Gedung COMLABS", B3).
propertyName("CC Timur", C1).
propertyName("CC Barat", C2).
propertyName("Lapangan", C3).
propertyName("Lab Fisika", D1).
propertyName("Lab Kimia", D2).
propertyName("Lab Informatika", D3).
propertyName("GKU Timur", E1).
propertyName("GKU Barat", E2).
propertyName("Oktagon", E3).
propertyName("CRCS", F1).
propertyName("CIBE", F2).
propertyName("CADL", F3).
propertyName("Perpustakaan Pusat", G1).
propertyName("Perpustakaan STEI", G2).
propertyName("Perpustakaan Sipil", G3).
propertyName("Aula Timur", H1).
propertyName("Aula Barat", H2).

/* propertyDesc(Desc, P) */
/* Desc adalah deskripsi properti P */
propertyDesc("Tempat perkuliahan Prodi IF, STI.", A1).
propertyDesc("Tempat akomodasi Tata Usaha STEI dan FMIPA.", A2).
propertyDesc("Tempat perkuliahan SITH-S.", A3).
propertyDesc("Gedung kerjasama PLN-ITB.", B1).
propertyDesc("Gedung kuliah serbaguna TVST.", B2).
propertyDesc("ComLabs USDI ITB.", B3).
propertyDesc("Campus Center Timur.", C1).
propertyDesc("Campus Center Barat.", C2).
propertyDesc("Area lapangan Basket dan Segitiga", C3).
propertyDesc("Tempat praktikum Fisika Dasar.", D1).
propertyDesc("Tempat praktikum Kimia Dasar.", D2).
propertyDesc("Tempat praktikum rumpun Informatika.", D3).
propertyDesc("Gedung Kuliah Umum Timur.", E1).
propertyDesc("Gedung Kuliah Umum Barat.", E2).
propertyDesc("Gedung kuliah serbaguna Oktagon.", E3).
propertyDesc("Center of Research and Community Services.", F1).
propertyDesc("Center of Infrastructure and Build Environment.", F2).
propertyDesc("Center of Arts, Design, and Language.", F3).
propertyDesc("Gedung perpustakaan utama.", G1).
propertyDesc("Perpustakaan di Labtek V.", G2).
propertyDesc("Perpustakaan di CIBE.", G3).
propertyDesc("Aula serbaguna timur.", H1).
propertyDesc("Aula serbaguna barat.", H2).

/* rent(RentCost, P) */
/* RentCost adalah biaya sewa properti P */

rentLand(750, A1).
rentLand(750, A2).
rentLand(1500, A3).
rentLand(1200, B1).
rentLand(1100, B2).
rentLand(1000, B3).
rentLand(1750, C1).
rentLand(1750, C2).
rentLand(500, C3).
rentLand(1000, D1).
rentLand(1000, D2).
rentLand(1250, D3).
rentLand(2000, E1).
rentLand(2000, E2).
rentLand(1750, E3).
rentLand(2250, F1).
rentLand(2150, F2).
rentLand(2250, F3).
rentLand(2000, G1).
rentLand(1850, G2).
rentLand(1900, G3).
rentLand(2000, H1).
rentLand(2000, H2).

rentClassOne(1500, A1).
rentClassOne(1500, A2).
rentClassOne(3000, A3).
rentClassOne(1400, B1).
rentClassOne(2200, B2).
rentClassOne(2000, B3).
rentClassOne(3500, C1).
rentClassOne(3500, C2).
rentClassOne(1000, C3).
rentClassOne(2000, D1).
rentClassOne(2000, D2).
rentClassOne(2500, D3).
rentClassOne(4000, E1).
rentClassOne(4000, E2).
rentClassOne(3500, E3).
rentClassOne(4500, F1).
rentClassOne(4300, F2).
rentClassOne(4500, F3).
rentClassOne(4000, G1).
rentClassOne(3700, G2).
rentClassOne(3800, G3).
rentClassOne(4000, H1).
rentClassOne(4000, H2).

rentClassTwo(2250, A1).
rentClassTwo(2250, A2).
rentClassTwo(4500, A3).
rentClassTwo(3600, B1).
rentClassTwo(3300, B2).
rentClassTwo(3000, B3).
rentClassTwo(5250, C1).
rentClassTwo(5250, C2).
rentClassTwo(1500, C3).
rentClassTwo(3000, D1).
rentClassTwo(3000, D2).
rentClassTwo(3750, D3).
rentClassTwo(6000, E1).
rentClassTwo(6000, E2).
rentClassTwo(5250, E3).
rentClassTwo(6750, F1).
rentClassTwo(6450, F2).
rentClassTwo(6750, F3).
rentClassTwo(6000, G1).
rentClassTwo(5550, G2).
rentClassTwo(5700, G3).
rentClassTwo(6000, H1).
rentClassTwo(6000, H2).

rentClassThree(3000, A1).
rentClassThree(3000, A2).
rentClassThree(6000, A3).
rentClassThree(4800, B1).
rentClassThree(4400, B2).
rentClassThree(4000, B3).
rentClassThree(7000, C1).
rentClassThree(7000, C2).
rentClassThree(2000, C3).
rentClassThree(4000, D1).
rentClassThree(4000, D2).
rentClassThree(5000, D3).
rentClassThree(8000, E1).
rentClassThree(8000, E2).
rentClassThree(7000, E3).
rentClassThree(9000, F1).
rentClassThree(8600, F2).
rentClassThree(9000, F3).
rentClassThree(8000, G1).
rentClassThree(7400, G2).
rentClassThree(7600, G3).
rentClassThree(8000, H1).
rentClassThree(8000, H2).

rentLandmark(3750, A1).
rentLandmark(3750, A2).
rentLandmark(7500, A3).
rentLandmark(6000, B1).
rentLandmark(5500, B2).
rentLandmark(5000, B3).
rentLandmark(8750, C1).
rentLandmark(8750, C2).
rentLandmark(2500, C3).
rentLandmark(5000, D1).
rentLandmark(5000, D2).
rentLandmark(6250, D3).
rentLandmark(10000, E1).
rentLandmark(10000, E2).
rentLandmark(8750, E3).
rentLandmark(11250, F1).
rentLandmark(10750, F2).
rentLandmark(11250, F3).
rentLandmark(10000, G1).
rentLandmark(9250, G2).
rentLandmark(9500, G3).
rentLandmark(10000, H1).
rentLandmark(10000, H2).

/* cost(BuyCost, P) */
/* BuyCost adalah harga beli properti P */

costLand(3000, A1).
costLand(3000, A2).
costLand(6000, A3).
costLand(4800, B1).
costLand(4400, B2).
costLand(4000, B3).
costLand(7000, C1).
costLand(7000, C2).
costLand(2000, C3).
costLand(4000, D1).
costLand(4000, D2).
costLand(5000, D3).
costLand(8000, E1).
costLand(8000, E2).
costLand(7000, E3).
costLand(9000, F1).
costLand(8600, F2).
costLand(9000, F3).
costLand(8000, G1).
costLand(7400, G2).
costLand(7600, G3).
costLand(8000, H1).
costLand(8000, H2).

costClassOne(6000, A1).
costClassOne(6000, A2).
costClassOne(12000, A3).
costClassOne(9600, B1).
costClassOne(8800, B2).
costClassOne(8000, B3).
costClassOne(14000, C1).
costClassOne(14000, C2).
costClassOne(4000, C3).
costClassOne(8000, D1).
costClassOne(8000, D2).
costClassOne(10000, D3).
costClassOne(16000, E1).
costClassOne(16000, E2).
costClassOne(14000, E3).
costClassOne(18000, F1).
costClassOne(17200, F2).
costClassOne(18000, F3).
costClassOne(16000, G1).
costClassOne(14800, G2).
costClassOne(15200, G3).
costClassOne(16000, H1).
costClassOne(16000, H2).

costClassTwo(9000, A1).
costClassTwo(9000, A2).
costClassTwo(18000, A3).
costClassTwo(14400, B1).
costClassTwo(13200, B2).
costClassTwo(12000, B3).
costClassTwo(21000, C1).
costClassTwo(21000, C2).
costClassTwo(6000, C3).
costClassTwo(12000, D1).
costClassTwo(12000, D2).
costClassTwo(15000, D3).
costClassTwo(24000, E1).
costClassTwo(24000, E2).
costClassTwo(21000, E3).
costClassTwo(27000, F1).
costClassTwo(25800, F2).
costClassTwo(27000, F3).
costClassTwo(24000, G1).
costClassTwo(22200, G2).
costClassTwo(22800, G3).
costClassTwo(24000, H1).
costClassTwo(24000, H2).

costClassThree(12000, A1).
costClassThree(12000, A2).
costClassThree(24000, A3).
costClassThree(19200, B1).
costClassThree(17600, B2).
costClassThree(16000, B3).
costClassThree(28000, C1).
costClassThree(28000, C2).
costClassThree(8000, C3).
costClassThree(16000, D1).
costClassThree(16000, D2).
costClassThree(20000, D3).
costClassThree(32000, E1).
costClassThree(32000, E2).
costClassThree(28000, E3).
costClassThree(36000, F1).
costClassThree(34400, F2).
costClassThree(36000, F3).
costClassThree(32000, G1).
costClassThree(29600, G2).
costClassThree(30400, G3).
costClassThree(32000, H1).
costClassThree(32000, H2).

costLandmark(15000, A1).
costLandmark(15000, A2).
costLandmark(30000, A3).
costLandmark(24000, B1).
costLandmark(22000, B2).
costLandmark(20000, B3).
costLandmark(35000, C1).
costLandmark(35000, C2).
costLandmark(10000, C3).
costLandmark(20000, D1).
costLandmark(20000, D2).
costLandmark(25000, D3).
costLandmark(40000, E1).
costLandmark(40000, E2).
costLandmark(35000, E3).
costLandmark(45000, F1).
costLandmark(43000, F2).
costLandmark(45000, F3).
costLandmark(40000, G1).
costLandmark(37000, G2).
costLandmark(38000, G3).
costLandmark(40000, H1).
costLandmark(40000, H2).

/* RULES */ 

/* Mengecek rincian dari sebuah properti, 
meliputi nama, deskripsi, biaya sewa, harga properti */
checkPropertyDetail(Prop) :-
    property(Prop),
    propertyName(Name, Prop),
    propertyDesc(Desc, Prop),
    costLand(BuyLand, Prop),
    costClassOne(BuyClassOne, Prop),
    costClassTwo(BuyClassTwo, Prop),
    costClassThree(BuyClassThree, Prop),
    costLandmark(BuyLandmark, Prop),
    rentLand(LandRent, Prop),
    rentClassOne(ClassOneRent, Prop),
    rentClassTwo(ClassTwoRent, Prop),
    rentClassThree(ClassThreeRent, Prop),
    rentLandmark(LandmarkRent, Prop),
    format('Nama Properti           : ~s ~n', [Name]),
    format('Deskripsi Properti      : ~s ~n', [Desc]),
    nl,
    format('Harga Tanah             : ~w ~n', [BuyLand]),
    format('Harga Bangunan 1        : ~w ~n', [BuyClassOne]),
    format('Harga Bangunan 2        : ~w ~n', [BuyClassTwo]),
    format('Harga Bangunan 3        : ~w ~n', [BuyClassThree]),
    format('Harga Landmark          : ~w ~n', [BuyLandmark]),
    nl,
    format('Biaya Sewa Tanah        : ~w ~n', [LandRent]),
    format('Biaya Sewa Bangunan 1   : ~w ~n', [ClassOneRent]),
    format('Biaya Sewa Bangunan 2   : ~w ~n', [ClassTwoRent]),
    format('Biaya Sewa Bangunan 3   : ~w ~n', [ClassThreeRent]),
    format('Biaya Sewa Landmark     : ~w ~n', [LandmarkRent]),
    !.
    
/* Mengecek klasifikasi dari properti */
classOfProperty(Prop) :-
    levelProp(Prop, X),
    format('Level properti  : ~w', [X]),
    !,
    nl.

