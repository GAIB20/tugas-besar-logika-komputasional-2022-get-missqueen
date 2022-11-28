
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
validLoc(cc01).
validLoc(f1).
validLoc(f2).
validLoc(f3).
validLoc(wt).
validLoc(g1).
validLoc(g2).
validLoc(g3).
validLoc(tx01).
validLoc(cc02).
validLoc(h1).
validLoc(h2).
validLoc(go).
validLoc(a1).
validLoc(a2).
validLoc(a3).
validLoc(cc03).
validLoc(b1).
validLoc(b2).
validLoc(b3).
validLoc(jl).
validLoc(c1).
validLoc(c2).
validLoc(c3).
validLoc(tx02).
validLoc(d1).
validLoc(d2).
validLoc(d3).

/* ADDITIONAL CHECKING */
/* Untuk lokasi yang namanya tidak unik */
/* syntax: chanceCard(Loc), tax(Loc) */
chanceCard(cc01).
chanceCard(cc02).
chanceCard(cc03).

tax(tx01).
tax(tx02).

/* DECODE COORDINATE TO LOCATION NAME */
/* Lokasi pada map dinyatakan sebagai angka. 0 dimulai dari kiri atas */
/* syntax: namaLoc(X,Loc) */
namaLoc(0,fp).
namaLoc(1,e1).
namaLoc(2,e2).
namaLoc(3,e3).
namaLoc(4,cc01).
namaLoc(5,f1).
namaLoc(6,f2).
namaLoc(7,f3).
namaLoc(8,wt).
namaLoc(9,g1).
namaLoc(10,g2).
namaLoc(11,g3).
namaLoc(12,tx01).
namaLoc(13,cc02).
namaLoc(14,h1).
namaLoc(15,h2).
namaLoc(16,go).
namaLoc(17,a1).
namaLoc(18,a2).
namaLoc(19,a3).
namaLoc(20,cc03).
namaLoc(21,b1).
namaLoc(22,b2).
namaLoc(23,b3).
namaLoc(24,jl).
namaLoc(25,c1).
namaLoc(26,c2).
namaLoc(27,c3).
namaLoc(28,tx02).
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
    format('~w apaan woi, jangan aneh-aneh deh.. Tolong masukin lokasi yang tepat. ~n',[Loc]),
    !.

/* Lokasi Nonproperti : Go */
checkLocationDetail(go) :-
    write('Nama Lokasi            : Go'),
    nl,
    write('Deskripsi Lokasi       : Tempat kamu mulai. Di sini kamu bisa:'), /* dummy dulu jumlah duitnya */
    nl,
    write('1. Beli properti.'),
    nl,
    write('2. Upgrade properti yang dimiliki jadi landmark.'),
    !.

/* Lokasi Nonproperti : Free Parking */
checkLocationDetail(fp) :-
    write('Nama Lokasi            : Free Parking'),
    nl,
    write('Deskripsi Lokasi       : Tempat ngechill.'),
    !.

/* Lokasi Nonproperti : Penjara */
checkLocationDetail(jl) :-
    write('Nama Lokasi            : Penjara'),
    nl,
    /* write('Deskripsi Lokasi       : kamu akan dikurung di sini kalau mendapatkan kartu masuk penjara atau mendapatkan double 3 kali berturut-turut. kamu akan diberikan kesempatan untuk bermain dadu selama tiga kali giliran. Untuk keluar dari sini, kamu harus: '), */
    write('Deskripsi Lokasi       : Kalo kamu naughty nanti daddy masukin ke sini, makanya gausah macem-macem dapet double 3 kali. Di sini kamu bisa: '),
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
    write('Deskripsi Lokasi       : Cosplay jadi orkay, banyak duit jadi terserah mau pecicilan ke mana aja. Tentunya dengan membayar uang sebesar 5% aset kamu.'),
    !.

/* Lokasi Nonproperti : Chance Card */
checkLocationDetail(Loc) :-
    chanceCard(Loc),
    write('Nama Lokasi            : Chance Card'),
    nl,
    write('Deskripsi Lokasi       : Judi itu haram jadi mending gausah ngapa-ngapain di sini. Tapi ya terserah dah, di sini kamu bisa dapet:'),
    nl,
    write('1. Kartu Tax, kamu langsung dipindahkan ke tempat Tax terdekat dan langsung dikenai pajak.'),
    nl,
    write('2. Kartu Hadiah, kamu langsung mendapatkan uang (haram) berdasarkan nilai yang tertera pada kartu tersebut.'),
    nl,
    write('3. Kartu Get Out From Jail, kamu dapat menggunakan kartu ini saat berada di dalam penjara untuk langsung keluar tanpa menunggu tiga kali giliran atau membayar denda.'),
    nl,
    write('4. Kartu Go To Jail, ya.. kamu masuk penjara.'),
    !.

/* Lokasi Nonproperti : Tax */
checkLocationDetail(Loc) :-
    tax(Loc),
    write('Nama Lokasi            : Tax'),
    nl,
    write('Deskripsi Lokasi       : Bayar biaya admin gan, taro 10% total asetmu di sini ^^'),
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
    
    format('Nama Lokasi           : ~w ~n',[Name]),
    format('Deskripsi Lokasi      : ~w ~n',[Desc]),
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
    
    format('Nama Lokasi           : ~w ~n',[Name]),
    format('Deskripsi Lokasi      : ~w ~n',[Desc]),
    nl,
    format('Kepemilikan           : ~w ~n',[Owner]),
    format('Biaya Sewa Saat Ini   : ~w ~n',[RentCost]),
    format('Biaya Akuisisi        : ~w ~n',[BuyCost]),
    format('Tingkatan Properti    : ~w ~n',[Level]),
    !.

/* NEAREST TAX LOCATION */
/* Mencari lokasi tax terdekat berikutnya */
/* syntax: nearestTax(CCnum,TaxLoc) */
nearestTax(cc01,tx01).
nearestTax(cc02,tx02).
nearestTax(cc02,tx02).

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
    asserta(playerCash(Player,NewBal)),
    retract(playerLocation(Player,PrevLoc)).

moveTo(Player,NewLoc)          :-
    playerLocation(Player,PrevLoc),
    \+ steppedStart(PrevLoc,NewLoc),
    playerCash(Player, PrevBal),
    asserta(playerLocation(Player,NewLoc)),
    asserta(playerCash(Player,PrevBal)),
    retract(playerLocation(Player,PrevLoc)).  

/* Move dari Dice: JALAN */
moveAfterRoll(Player,Roll)  :-
    playerLocation(Player,PrevLoc),
    rollDiceLoc(Roll,PrevLoc,NewLoc),
    moveTo(Player,NewLoc).

/* Teleport ke Suatu Tempat: TIDAK JALAN (LONCAT) */
/* contoh penggunaan: saat pengguna mendapat cc masuk penjara, pengguna LONCAT ke penjara (tidak jalan) */
teleportTo(Player,Loc)     :-
    playerLocation(Player,PrevLoc),
    retract(playerLocation(Player,PrevLoc)),
    asserta(playerLocation(Player,Loc)).