:- consult('property.pl').
:- consult('player.pl').
:- consult('utils.pl').

/* what's inside */
/*  - check location validity
        status: ok
    - decode number to location name
        status: ok
    - find location after rolling a dice
        status: ok
    - find owner of a property location
        status: utk yg biasanya udh aman, tapi belom check lagi kalo untuk dinamiknya (karna listpropnya berubah2 terus)
    - check location detail
        status: yang wt nunggu % nya, untuk go apakah dapat duit kl lewat, belom uppercase2in
    - player location -> ada di bagian file player.pl dengan predikat playerLocation()
    - nearest tax location (untuk chance card kartu tax, butuh pindah ke tempat tax terdekat berikutnya 
    - move player method: move/ teleport 
    */

/* Note: untuk player location & cash di sini cuman asserta aja (ga ada retract), retract2 kalo mau sekalian aja di main buat retract semua statenya biar gak backtracking */

/* CHECK LOCATION VALIDITY */
/* syntax: validLoc(Loc) */
validLoc(fp).
validLoc(e1).
validLoc(e2).
validLoc(e3).
validLoc(cc1).
validLoc(f1).
validLoc(f2).
validLoc(f3).
validLoc(wt).
validLoc(g1).
validLoc(g2).
validLoc(g3).
validLoc(tx1).
validLoc(cc2).
validLoc(h1).
validLoc(h2).
validLoc(go).
validLoc(a1).
validLoc(a2).
validLoc(a3).
validLoc(cc3).
validLoc(b1).
validLoc(b2).
validLoc(b3).
validLoc(jl).
validLoc(c1).
validLoc(c2).
validLoc(c3).
validLoc(tx2).
validLoc(d1).
validLoc(d2).
validLoc(d3).

/* ADDITIONAL CHECKING */
/* Untuk lokasi yang namanya tidak unik */
/* syntax: chanceCard(Loc), tax(Loc) */
chanceCard(cc1).
chanceCard(cc2).
chanceCard(cc3).

tax(tx1).
tax(tx2).

/* DECODE COORDINATE TO LOCATION NAME */
/* Lokasi pada map dinyatakan sebagai angka. 0 dimulai dari kiri atas */
/* syntax: namaLoc(X,Loc) */
namaLoc(0,fp).
namaLoc(1,e1).
namaLoc(2,e2).
namaLoc(3,e3).
namaLoc(4,cc1).
namaLoc(5,f1).
namaLoc(6,f2).
namaLoc(7,f3).
namaLoc(8,wt).
namaLoc(9,g1).
namaLoc(10,g2).
namaLoc(11,g3).
namaLoc(12,tx1).
namaLoc(13,cc2).
namaLoc(14,h1).
namaLoc(15,h2).
namaLoc(16,go).
namaLoc(17,a1).
namaLoc(18,a2).
namaLoc(19,a3).
namaLoc(20,cc3).
namaLoc(21,b1).
namaLoc(22,b2).
namaLoc(23,b3).
namaLoc(24,jl).
namaLoc(25,c1).
namaLoc(26,c2).
namaLoc(27,c3).
namaLoc(28,tx2).
namaLoc(29,d1).
namaLoc(30,d2).
namaLoc(31,d3).

/* LOCATION AFTER ROLLLING DICE */
/* syntax: rollDiceLoc(Roll,PrevLoc,Newloc) */
rollDiceLoc(Roll,PrevLoc,NewLoc) :-
    namaLoc(X,PrevLoc),
    Y is (X + Roll) mod 32,
    namaLoc(Y,NewLoc).

/* FIND OWNER OF PROPERTY LOCATION */


/* Fungsi Utama */
/* Mencari pemilik dari property */
/* syntax: ownProp(Player,Prop) */
ownProp(Player,Prop)    :-
    playerPropList(Player, PropList),
    inList(PropList,Prop,1).

/* CHECK LOCATION DETAIL */
/* Mengecek detail lokasi */
/* syntax: checkLocationDetail(Loc) */
/* Lokasi Tidak Valid */
checkLocationDetail(Loc) :-
    \+ validLoc(Loc),
    /* Ini harusnya printnya uppercase LOC */
    format('~w bukan merupakan lokasi yang valid! Silahkan masukkan lokasi yang tepat~n',[Loc]),
    !.

/* Lokasi Nonproperti : Go */
checkLocationDetail(go) :-
    write('Nama Lokasi            : Go'),
    nl,
    write('Deskripsi Lokasi       : Ini adalah tempat start seluruh pemain. Setiap melewatinya setelah 1 putaran, Anda akan mendapatkan tambahan uang sebesar 1000.'), /* dummy dulu jumlah duitnya */
    !.

/* Lokasi Nonproperti : Free Parking */
checkLocationDetail(fp) :-
    write('Nama Lokasi            : Free Parking'),
    nl,
    write('Deskripsi Lokasi       : Tidak ada efek apa-apa jika menginjak tempat ini.'),
    !.

/* Lokasi Nonproperti : Penjara */
checkLocationDetail(jl) :-
    write('Nama Lokasi            : Penjara'),
    nl,
    write('Deskripsi Lokasi       : Anda akan dikurung di sini kalau mendapatkan kartu masuk penjara atau mendapatkan double 3 kali berturut-turut. Anda akan diberikan kesempatan untuk bermain dadu selama tiga kali giliran. Untuk keluar dari sini, Anda harus: '),
    nl,
    write('- Mendapat dadu double sebelum tiga kali giliran,'),
    nl,
    write('- Sudah melempar dadu tiga kali,'),
    nl,
    write('- Mempunyai kartu lolos dari penjara, atau'),
    nl,
    write('- Membayar denda pada giliran berikutnya,'),
    !.

/* Lokasi Nonproperti : World Tour */
checkLocationDetail(wt) :-
    write('Nama Lokasi            : World Tour'),
    nl,
    write('Deskripsi Lokasi       : Anda dapat berpindah kemana saja, tentunya dengan membayar uang sebesar X% aset Anda.'),
    !.

/* Lokasi Nonproperti : Chance Card */
checkLocationDetail(Loc) :-
    chanceCard(Loc),
    write('Nama Lokasi            : Chance Card'),
    nl,
    write('Deskripsi Lokasi       : Apakah Anda sedang merasa beruntung? Disinilah tempatnya! Anda berhak mendapatkan salah satu dari kartu berikut :'),
    nl,
    write('1. Kartu Tax, Anda akan langsung pindah ke tempat Tax berikutnya (terdekat) dan langsung dikenai pajak.'),
    nl,
    write('2. Kartu Hadiah, Anda langsung mendapatkan uang berdasarkan nilai yang tertera pada kartu tersebut.'),
    nl,
    write('3. Kartu Get Out From Jail, Anda dapat menggunakan kartu ini saat berada di dalam penjara untuk langsung keluar tanpa menunggu tiga kali giliran atau membayar denda.'),
    nl,
    write('4. Kartu Go To Jail, Anda langsung ditransportasi ke lokasi Penjara dan dipenjara. Permainan dilanjutkan oleh pemain selanjutnya.'),
    !.

/* Lokasi Nonproperti : Tax */
checkLocationDetail(Loc) :-
    tax(Loc),
    write('Nama Lokasi            : Tax'),
    nl,
    write('Deskripsi Lokasi       : Anda merasa meng-sultan? Injak tempat ini dan sedekahkan 10% total asetmu di sini ^^'),
    !.

/* Lokasi Properti (Belum Ada Pemilik) */
checkLocationDetail(Loc) :-
    validLoc(Loc),
    property(Loc),
    propertyName(Name, Loc),
    propertyDesc(Desc, Loc),
    levelProp(Loc,Level),
    rent(RentCost, Loc, Level),
    cost(BuyCost, Loc, Level),
    \+ ownProp(_, Loc),
    
    format('Nama Lokasi           : ~s ~n',[Name]),
    format('Deskripsi Lokasi      : ~s ~n',[Desc]),
    nl,
    write('Kepemilikan           : -'),
    nl,
    format('Biaya Sewa Saat Ini   : ~w ~n',[RentCost]),
    format('Biaya Akuisisi        : ~w ~n',[BuyCost]),
    format('Tingkatan Properti    : ~w ~n',[Level]),
    !.

/* Lokasi Properti (Ada Pemilik) */
checkLocationDetail(Loc) :-
    validLoc(Loc),
    property(Loc),
    propertyName(Name, Loc),
    propertyDesc(Desc, Loc),
    levelProp(Loc,Level),
    rent(RentCost, Loc, Level),
    cost(BuyCost, Loc, Level),
    ownProp(Owner, Loc),
    
    format('Nama Lokasi           : ~s ~n',[Name]),
    format('Deskripsi Lokasi      : ~s ~n',[Desc]),
    nl,
    format('Kepemilikan           : ~w ~n',[Owner]),
    format('Biaya Sewa Saat Ini   : ~w ~n',[RentCost]),
    format('Biaya Akuisisi        : ~w ~n',[BuyCost]),
    format('Tingkatan Properti    : ~w ~n',[Level]),
    !.

/* NEAREST TAX LOCATION */
/* Mencari lokasi tax terdekat berikutnya */
/* syntax: nearestTax(CCnum,TaxLoc) */
nearestTax(cc1,tx1).
nearestTax(cc2,tx2).
nearestTax(cc2,tx2).

/* IS START STEPPED? */
/* Mengecek apakah start berada di antara (inklusif) PrevLoc dan NewLoc */
steppedStart(PrevLoc,NewLoc)   :-
    namaLoc(X,PrevLoc),
    namaLoc(Y,NewLoc),
    Y =< X.

/* MOVE PLAYER */

/* Move ke Suatu Tempat: JALAN */
/* contoh penggunaan: world tour jalan bukan loncat */
moveTo(Player,NewLoc)          :-
    playerLocation(Player,PrevLoc),
    steppedStart(PrevLoc,NewLoc),
    playerCash(Player, PrevBal),
    NewBal is PrevBal + 1000, /* dummy dulu kalo lewat start */
    asserta(playerLocation(Player,NewLoc)),
    asserta(playerCash(Player,NewBal)).

moveTo(Player,NewLoc)          :-
    playerLocation(Player,PrevLoc),
    \+ steppedStart(PrevLoc,NewLoc),
    playerCash(Player, PrevBal),
    asserta(playerLocation(Player,NewLoc)),
    asserta(playerCash(Player,PrevBal)).  

/* Move dari Dice: JALAN */
moveAfterRoll(Player,Roll)  :-
    playerLocation(Player,PrevLoc),
    rollDiceLoc(Roll,PrevLoc,NewLoc),
    moveTo(Player,NewLoc).

/* Teleport ke Suatu Tempat: TIDAK JALAN (LONCAT) */
/* contoh penggunaan: saat pengguna mendapat cc masuk penjara, pengguna LONCAT ke penjara (tidak jalan) */
teleportTo(Player,Loc)     :-
    asserta(playerLocation(Player,Loc)).