:- include('player.pl').

/* FACTS */

/* Identity */
/* property(Name) */
/* Menunjukkan apabila Name adalah property atau non-property */
property(a1).
property(a2).
property(a3).
property(b1).
property(b2).
property(b3).
property(c1).
property(c2).
property(c3).
property(d1).
property(d2).
property(d3).
property(e1).
property(e2).
property(e3).
property(f1).
property(f2).
property(f3).
property(g1).
property(g2).
property(g3).
property(h1).
property(h2).

/* Classifier */
/* Level dari property */
/* levelProp(Level, Prop) */
:- dynamic(levelProp/2).
levelProp(a1, 0).
levelProp(a2, 0).
levelProp(a3, 0).
levelProp(b1, 0).
levelProp(b2, 0).
levelProp(b3, 0).
levelProp(c1, 0).
levelProp(c2, 0).
levelProp(c3, 0).
levelProp(d1, 0).
levelProp(d2, 0).
levelProp(d3, 0).
levelProp(e1, 0).
levelProp(e2, 0).
levelProp(e3, 0).
levelProp(f1, 0).
levelProp(f2, 0).
levelProp(f3, 0).
levelProp(g1, 0).
levelProp(g2, 0).
levelProp(g3, 0).
levelProp(h1, 0).
levelProp(h2, 0).

/* Property Information */

/* propertyName(Name, P) */
/* Name adalah nama properti P */

propertyName("Labtek V", a1).
propertyName("Labtek VIII", a2).
propertyName("Labtek Biru", a3).
propertyName("Gedung PLN", b1).
propertyName("Gedung TVST", b2).
propertyName("Gedung COMLABS", b3).
propertyName("CC Timur", c1).
propertyName("CC Barat", c2).
propertyName("Lapangan", c3).
propertyName("Lab Fisika", d1).
propertyName("Lab Kimia", d2).
propertyName("Lab Informatika", d3).
propertyName("GKU Timur", e1).
propertyName("GKU Barat", e2).
propertyName("Oktagon", e3).
propertyName("CRCS", f1).
propertyName("CIBE", f2).
propertyName("CADL", f3).
propertyName("Perpustakaan Pusat", g1).
propertyName("Perpustakaan STEI", g2).
propertyName("Perpustakaan Sipil", g3).
propertyName("Aula Timur", h1).
propertyName("Aula Barat", h2).

/* propertyDesc(Desc, P) */
/* Desc adalah deskripsi properti P */
propertyDesc("Tempat perkuliahan Prodi IF, STI", a1).
propertyDesc("Tempat akomodasi Tata Usaha STEI dan FMIPA", a2).
propertyDesc("Tempat perkuliahan SITH-S", a3).
propertyDesc("Gedung kerjasama PLN-ITB", b1).
propertyDesc("Gedung kuliah serbaguna TVST", b2).
propertyDesc("ComLabs USDI ITB", b3).
propertyDesc("Campus Center Timur", c1).
propertyDesc("Campus Center Barat", c2).
propertyDesc("Area lapangan Basket dan Segitiga", c3).
propertyDesc("Tempat praktikum Fisika Dasar", d1).
propertyDesc("Tempat praktikum Kimia Dasar", d2).
propertyDesc("Tempat praktikum rumpun Informatika", d3).
propertyDesc("Gedung Kuliah Umum Timur", e1).
propertyDesc("Gedung Kuliah Umum Barat", e2).
propertyDesc("Gedung kuliah serbaguna Oktagon", e3).
propertyDesc("Center of Research and Community Services", f1).
propertyDesc("Center of Infrastructure and Build Environment", f2).
propertyDesc("Center of Arts, Design, and Language", f3).
propertyDesc("Gedung perpustakaan utama", g1).
propertyDesc("Perpustakaan di Labtek V", g2).
propertyDesc("Perpustakaan di CIBE", g3).
propertyDesc("Aula serbaguna timur", h1).
propertyDesc("Aula serbaguna barat", h2).

/* rent(RentCost, P, L) */
/* RentCost adalah biaya sewa properti P dengan level L */

rent(750, a1, 0).
rent(750, a2, 0).
rent(1500, a3, 0).
rent(1200, b1, 0).
rent(1100, b2, 0).
rent(1000, b3, 0).
rent(1750, c1, 0).
rent(1750, c2, 0).
rent(500, c3, 0).
rent(1000, d1, 0).
rent(1000, d2, 0).
rent(1250, d3, 0).
rent(2000, e1, 0).
rent(2000, e2, 0).
rent(1750, e3, 0).
rent(2250, f1, 0).
rent(2150, f2, 0).
rent(2250, f3, 0).
rent(2000, g1, 0).
rent(1850, g2, 0).
rent(1900, g3, 0).
rent(2000, h1, 0).
rent(2000, h2, 0).

rent(1500, a1, 1).
rent(1500, a2, 1).
rent(3000, a3, 1).
rent(1400, b1, 1).
rent(2200, b2, 1).
rent(2000, b3, 1).
rent(3500, c1, 1).
rent(3500, c2, 1).
rent(1000, c3, 1).
rent(2000, d1, 1).
rent(2000, d2, 1).
rent(2500, d3, 1).
rent(4000, e1, 1).
rent(4000, e2, 1).
rent(3500, e3, 1).
rent(4500, f1, 1).
rent(4300, f2, 1).
rent(4500, f3, 1).
rent(4000, g1, 1).
rent(3700, g2, 1).
rent(3800, g3, 1).
rent(4000, h1, 1).
rent(4000, h2, 1).

rent(2250, a1, 2).
rent(2250, a2, 2).
rent(4500, a3, 2).
rent(3600, b1, 2).
rent(3300, b2, 2).
rent(3000, b3, 2).
rent(5250, c1, 2).
rent(5250, c2, 2).
rent(1500, c3, 2).
rent(3000, d1, 2).
rent(3000, d2, 2).
rent(3750, d3, 2).
rent(6000, e1, 2).
rent(6000, e2, 2).
rent(5250, e3, 2).
rent(6750, f1, 2).
rent(6450, f2, 2).
rent(6750, f3, 2).
rent(6000, g1, 2).
rent(5550, g2, 2).
rent(5700, g3, 2).
rent(6000, h1, 2).
rent(6000, h2, 2).

rent(3000, a1, 3).
rent(3000, a2, 3).
rent(6000, a3, 3).
rent(4800, b1, 3).
rent(4400, b2, 3).
rent(4000, b3, 3).
rent(7000, c1, 3).
rent(7000, c2, 3).
rent(2000, c3, 3).
rent(4000, d1, 3).
rent(4000, d2, 3).
rent(5000, d3, 3).
rent(8000, e1, 3).
rent(8000, e2, 3).
rent(7000, e3, 3).
rent(9000, f1, 3).
rent(8600, f2, 3).
rent(9000, f3, 3).
rent(8000, g1, 3).
rent(7400, g2, 3).
rent(7600, g3, 3).
rent(8000, h1, 3).
rent(8000, h2, 3).

rent(3750, a1, 4).
rent(3750, a2, 4).
rent(7500, a3, 4).
rent(6000, b1, 4).
rent(5500, b2, 4).
rent(5000, b3, 4).
rent(8750, c1, 4).
rent(8750, c2, 4).
rent(2500, c3, 4).
rent(5000, d1, 4).
rent(5000, d2, 4).
rent(6250, d3, 4).
rent(10000, e1, 4).
rent(10000, e2, 4).
rent(8750, e3, 4).
rent(11250, f1, 4).
rent(10750, f2, 4).
rent(11250, f3, 4).
rent(10000, g1, 4).
rent(9250, g2, 4).
rent(9500, g3, 4).
rent(10000, h1, 4).
rent(10000, h2, 4).

/* cost(BuyCost, P, L) */
/* BuyCost adalah harga beli properti P dengan level L */

cost(3000, a1, 0).
cost(3000, a2, 0).
cost(6000, a3, 0).
cost(4800, b1, 0).
cost(4400, b2, 0).
cost(4000, b3, 0).
cost(7000, c1, 0).
cost(7000, c2, 0).
cost(2000, c3, 0).
cost(4000, d1, 0).
cost(4000, d2, 0).
cost(5000, d3, 0).
cost(8000, e1, 0).
cost(8000, e2, 0).
cost(7000, e3, 0).
cost(9000, f1, 0).
cost(8600, f2, 0).
cost(9000, f3, 0).
cost(8000, g1, 0).
cost(7400, g2, 0).
cost(7600, g3, 0).
cost(8000, h1, 0).
cost(8000, h2, 0).

cost(6000, a1, 1).
cost(6000, a2, 1).
cost(12000, a3, 1).
cost(9600, b1, 1).
cost(8800, b2, 1).
cost(8000, b3, 1).
cost(14000, c1, 1).
cost(14000, c2, 1).
cost(4000, c3, 1).
cost(8000, d1, 1).
cost(8000, d2, 1).
cost(10000, d3, 1).
cost(16000, e1, 1).
cost(16000, e2, 1).
cost(14000, e3, 1).
cost(18000, f1, 1).
cost(17200, f2, 1).
cost(18000, f3, 1).
cost(16000, g1, 1).
cost(14800, g2, 1).
cost(15200, g3, 1).
cost(16000, h1, 1).
cost(16000, h2, 1).

cost(9000, a1, 2).
cost(9000, a2, 2).
cost(18000, a3, 2).
cost(14400, b1, 2).
cost(13200, b2, 2).
cost(12000, b3, 2).
cost(21000, c1, 2).
cost(21000, c2, 2).
cost(6000, c3, 2).
cost(12000, d1, 2).
cost(12000, d2, 2).
cost(15000, d3, 2).
cost(24000, e1, 2).
cost(24000, e2, 2).
cost(21000, e3, 2).
cost(27000, f1, 2).
cost(25800, f2, 2).
cost(27000, f3, 2).
cost(24000, g1, 2).
cost(22200, g2, 2).
cost(22800, g3, 2).
cost(24000, h1, 2).
cost(24000, h2, 2).

cost(12000, a1, 3).
cost(12000, a2, 3).
cost(24000, a3, 3).
cost(19200, b1, 3).
cost(17600, b2, 3).
cost(16000, b3, 3).
cost(28000, c1, 3).
cost(28000, c2, 3).
cost(8000, c3, 3).
cost(16000, d1, 3).
cost(16000, d2, 3).
cost(20000, d3, 3).
cost(32000, e1, 3).
cost(32000, e2, 3).
cost(28000, e3, 3).
cost(36000, f1, 3).
cost(34400, f2, 3).
cost(36000, f3, 3).
cost(32000, g1, 3).
cost(29600, g2, 3).
cost(30400, g3, 3).
cost(32000, h1, 3).
cost(32000, h2, 3).

cost(15000, a1, 4).
cost(15000, a2, 4).
cost(30000, a3, 4).
cost(24000, b1, 4).
cost(22000, b2, 4).
cost(20000, b3, 4).
cost(35000, c1, 4).
cost(35000, c2, 4).
cost(10000, c3, 4).
cost(20000, d1, 4).
cost(20000, d2, 4).
cost(25000, d3, 4).
cost(40000, e1, 4).
cost(40000, e2, 4).
cost(35000, e3, 4).
cost(45000, f1, 4).
cost(43000, f2, 4).
cost(45000, f3, 4).
cost(40000, g1, 4).
cost(37000, g2, 4).
cost(38000, g3, 4).
cost(40000, h1, 4).
cost(40000, h2, 4).

/* RULES */ 

/* Mengecek rincian dari sebuah properti, 
meliputi nama, deskripsi, biaya sewa, harga properti */
checkPropertyDetail(Prop) :-
    property(Prop),
    propertyName(Name, Prop),
    propertyDesc(Desc, Prop),
    cost(BuyLand, Prop, 0),
    cost(BuyClassOne, Prop, 1),
    cost(BuyClassTwo, Prop, 2),
    cost(BuyClassThree, Prop, 3),
    cost(BuyLandmark, Prop, 4),
    rent(LandRent, Prop, 0),
    rent(ClassOneRent, Prop, 1),
    rent(ClassTwoRent, Prop, 2),
    rent(ClassThreeRent, Prop, 3),
    rent(LandmarkRent, Prop, 4),
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

/* Mengecek apabila properti sudah dimiliki */
/* Basis */
isPropertyOwned([], _Property, Owned) :- Owned = 0.

/* Rekurens */
isPropertyOwned([Head|_Tail], Property, Owned) :- 
    Head == Property,
    Owned = 1.
isPropertyOwned([Head|Tail], Property, Owned) :- 
    Head \= Property, 
    isPropertyOwned(Tail, Property, Owned).

/* Akuisisi properti */
buyProperty(Player, Location) :-
    property(Location) -> (
        propertyName(PropName, Location),
        levelProp(Location, Level),
        cost(Cost, Location, Level),
        playerCash(Player, Cash),
        playerPropList(Player, PropList),
        isPropertyOwned(PropList, Location, Owned),
        (
            (Cash >= Cost) -> (
                (Owned =:= 0) -> (
                    retract(playerPropList(Player, OldPropList)),
                    NewPropList = [Location|OldPropList],
                    assertz(playerPropList(Player, NewPropList)),
                    retract(playerCash(Player, OldCash)),
                    NewCash is (OldCash-Cost),
                    assertz(playerCash(Player, NewCash)),
                    format('~s berhasil diakusisi. Sisa uang Anda adalah ~w ~n', [PropName, NewCash]), !
                ) ; write('Anda sudah memiliki properti ini!'), nl, !    
            ) ; format('Anda miskin! Cari uang sebanyak ~w untuk membeli properti ini. ~n', [Cost]), !
        )
    ) ; write('Anda tidak ada pada properti!'), nl, !.