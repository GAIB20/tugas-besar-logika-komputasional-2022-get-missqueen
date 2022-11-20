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

rent(750, A1).
rent(750, A2).
rent(1500, A3).
rent(1200, B1).
rent(1100, B2).
rent(1000, B3).
rent(1750, C1).
rent(1750, C2).
rent(500, C3).
rent(1000, D1).
rent(1000, D2).
rent(1250, D3).
rent(2000, E1).
rent(2000, E2).
rent(1750, E3).
rent(2250, F1).
rent(2150, F2).
rent(2250, F3).
rent(2000, G1).
rent(1850, G2).
rent(1900, G3).
rent(2000, H1).
rent(2000, H2).

/* cost(BuyCost, P) */
/* BuyCost adalah harga beli properti P */

rent(3000, A1).
rent(3000, A2).
rent(6000, A3).
rent(4800, B1).
rent(4400, B2).
rent(4000, B3).
rent(7000, C1).
rent(7000, C2).
rent(2000, C3).
rent(4000, D1).
rent(4000, D2).
rent(5000, D3).
rent(8000, E1).
rent(8000, E2).
rent(7000, E3).
rent(9000, F1).
rent(8600, F2).
rent(9000, F3).
rent(8000, G1).
rent(7400, G2).
rent(7600, G3).
rent(8000, H1).
rent(8000, H2).