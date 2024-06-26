class Truck {
  String placa;
  String empresa;
  String marca;
  String color;

  Truck({
    required this.placa,
    required this.empresa,
    required this.marca,
    required this.color,
  });
}

  List<Truck> trucks = [
  Truck(placa: "159014", empresa: "PROPIO", marca: "FREIGHTLINER", color: "AZUL"),
  Truck(placa: "145199", empresa: "RICARDO ALVARADO", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "174043", empresa: "", marca: "PETERBILT", color: "VINO"),
  Truck(placa: "154295", empresa: "PROPIO", marca: "KENWORTH", color: "AZUL"),
  Truck(placa: "165232", empresa: "SERVICIOS MF", marca: "FREIGHTLINER", color: "ROJO"),
  Truck(placa: "143890", marca: "FREIGHTLINER", color: "ROJO", empresa: ''),
  Truck(placa: "159411", marca: "VOLVO", color: "ROJO", empresa: ''),
  Truck(placa: "157946", empresa: "ALBERTO MENDEZ", marca: "FREIGHTLINER", color: "VERDE"),
  Truck(placa: "152877", empresa: "PROPIO", marca: "VOLVO", color: "ROJO"),
  Truck(placa: "139116", empresa: "PROPIO", marca: "FREIGHTLINER", color: "VERDE"),
  Truck(placa: "152273", empresa: "PROPIO", marca: "FREIGHTLINER", color: "VERDE"),
  Truck(placa: "150005", empresa: "CORDOBA", marca: "FREIGHTLINER", color: "NEGRO"),
  Truck(placa: "173709", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "148492", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "145301", empresa: "ALBERTO MENDEZ", marca: "FREIGHTLINER", color: "AMARILLO"),
  Truck(placa: "142439", marca: "FREIGHTLINER", color: "BLANCO", empresa: ''),
  Truck(placa: "134903", marca: "FREIGHTLINER", color: "CELESTE", empresa: ''),
  Truck(placa: "129443", empresa: "PROPIO", marca: "INTERNATIONAL", color: "ROJO"),
  Truck(placa: "169677", empresa: "PROPIO", marca: "FREIGHTLINER", color: "ROJO"),
  Truck(placa: "178146", empresa: "EDGAR SALGUERO", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "154159", marca: "VOLVO", color: "ROJO", empresa: ''),
  Truck(placa: "136462", empresa: "PROPIO", marca: "KENWORTH", color: "VERDE"),
  Truck(placa: "132894", empresa: "PROPIO", marca: "PETERBILT", color: "BLANCO"),
  Truck(placa: "127432", empresa: "PROPIO", marca: "INTERNATIONAL", color: "BLANCO"),
  Truck(placa: "165403", marca: "FREIGHTLINER", color: "NEGRO", empresa: ''),
  Truck(placa: "125868", empresa: "PROPIO", marca: "FREIGHTLINER", color: "VERDE"),
  Truck(placa: "171950", empresa: "MAURICIO SEGURA", marca: "FREIGHTLINER", color: "AZUL"),
  Truck(placa: "156035", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "142973", empresa: "ANDREY GUERRERO", marca: "INTERNATIONAL", color: "BLANCO"),
  Truck(placa: "133081", marca: "FREIGHTLINER", color: "BLANCO", empresa: ''),
  Truck(placa: "139524", marca: "FREIGHTLINER", color: "AZUL", empresa: ''),
  Truck(placa: "129673", empresa: "PROPIO", marca: "INTERNATIONAL", color: "BLANCO"),
  Truck(placa: "165085", empresa: "ALBERT CASTRO", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "143903", marca: "KENWORTH", color: "AZUL", empresa: ''),
  Truck(placa: "152366", empresa: "PROPIO", marca: "FREIGHTLINER", color: "MORADO"),
  Truck(placa: "175748", empresa: "PROPIO", marca: "KENWORTH", color: "AZUL"),
  Truck(placa: "140717", empresa: "ACAYA", marca: "FREIGHTLINER", color: "DORADO"),
  Truck(placa: "152679", empresa: "FERNANDO H", marca: "FREIGHTLINER", color: "ROJO"),
  Truck(placa: "160442", empresa: "G Y K", marca: "FREIGHTLINER", color: "AZUL"),
  Truck(placa: "160610", empresa: "ANTOJADO", marca: "FREIGHTLINER", color: "BEIGE"),
  Truck(placa: "154519", empresa: "ANTOJADO", marca: "KENWORTH", color: "ROJO"),
  Truck(placa: "169607", empresa: "ANTOJADO", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "152807", empresa: "ANTOJADO", marca: "FREIGHTLINER", color: "NEGRO"),
  Truck(placa: "162942", empresa: "TRANS VASQUEZ", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "169871", empresa: "TRANS VASQUEZ", marca: "FREIGHTLINER", color: "NEGRO"),
  Truck(placa: "169005", empresa: "TRANS VASQUEZ", marca: "FREIGHTLINER", color: "AZUL"),
  Truck(placa: "162124", empresa: "TRANS VASQUEZ", marca: "FREIGHTLINER", color: "AZUL"),
  Truck(placa: "177740", empresa: "TRANS VASQUEZ", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "164281", empresa: "BOHESA", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "158000", empresa: "BOHESA", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "151897", empresa: "BOHESA", marca: "FREIGHTLINER", color: "ROJO"),
  Truck(placa: "156163", empresa: "BOHESA", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "163819", empresa: "BOHESA", marca: "FREIGHTLINER", color: "DORADO"),
  Truck(placa: "165147", empresa: "BOHESA", marca: "KENWORTH", color: "BLANCO"),
  Truck(placa: "156744", empresa: "BOHESA", marca: "PETERBILT", color: "AZUL"),
  Truck(placa: "140198", empresa: "BOHESA", marca: "KENWORTH", color: "ROJO"),
  Truck(placa: "151065", empresa: "TRASA", marca: "FREIGHTLINER", color: "VERDE"),
  Truck(placa: "135168", empresa: "TRASA", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "171314", empresa: "LA SOYA", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "171336", empresa: "PROPIO", marca: "FREIGHTLINER", color: "CELESTE"),
  Truck(placa: "169443", empresa: "TONY VAGAS", marca: "FREIGHTLINER", color: "AZUL"),
  Truck(placa: "168611", empresa: "LA SOYA", marca: "SINO TRUCK", color: "BLANCO"),
  Truck(placa: "158916", empresa: "PROPIO", marca: "KENWORTH", color: "ROJO"),
  Truck(placa: "161619", empresa: "HARLAN CESPEDES", marca: "FREIGHTLINER", color: "ANARANJADO"),
    Truck(placa: "165416", empresa: "HARLAN CESPEDES", marca: "VOLVO", color: "VINO"),
    Truck(placa: "153277", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
    Truck(placa: "144000", empresa: "MAURICIO SIBAJA", marca: "FREIGHTLINER", color: "BLANCO"),
    Truck(placa: "170343", empresa: "Q Y S", marca: "INTERNATIONAL", color: "BLANCO"),
    Truck(placa: "166117", empresa: "Q Y S", marca: "FREIGHTLINER", color: "AZUL"),
    Truck(placa: "147823", empresa: "CARLOS VALDE", marca: "FREIGHTLINER", color: "ROJO"),
    Truck(placa: "151152", empresa: "CARLOS VALDE", marca: "FREIGHTLINER", color: "ROJO"),
    Truck(placa: "139532", empresa: "CARLOS VALDE", marca: "FREIGHTLINER", color: "CAFÉ"),
    Truck(placa: "137672", empresa: "PROPIO", marca: "FREIGHTLINER", color: "GRIS"),
    Truck(placa: "168999", empresa: "PROPIO", marca: "FREIGHTLINER", color: "AZUL"),
    Truck(placa: "157508", empresa: "PROPIO", marca: "VOLVO", color: "ROJO"),
    Truck(placa: "147125", empresa: "EDGAR SALGUERO", marca: "FREIGHTLINER", color: "VERDE"),
    Truck(placa: "152335", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
    Truck(placa: "143718", empresa: "ELIANDER CORDOBA", marca: "KENWORTH", color: "VINO"),
    Truck(placa: "148504", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
    Truck(placa: "165616", empresa: "PROPIO", marca: "FREIGHTLINER", color: "VERDE"),
    Truck(placa: "144011", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
    Truck(placa: "171102", empresa: "JHON LIZANO", marca: "FREIGHTLINER", color: "ROJO"),
    Truck(placa: "164922", empresa: "JHON LIZANO", marca: "FREIGHTLINER", color: "NEGRO"),
    Truck(placa: "157739", empresa: "MANRIQUE PEROLA", marca: "FREIGHTLINER", color: "BLANCO"),
    Truck(placa: "152998", empresa: "PROPIO", marca: "VOLVO", color: "BLANCO"),
    Truck(placa: "157803", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
    Truck(placa: "160465", empresa: "PROPIO", marca: "FREIGHTLINER", color: "ROJO"),
    Truck(placa: "175256", empresa: "CHATARRERO", marca: "FREIGHTLINER", color: "BLANCO"),
    Truck(placa: "175147", empresa: "PROPIO", marca: "PETERBILT", color: "CREMA"),
    Truck(placa: "164961", empresa: "PROPIO", marca: "KENWORTH", color: "BLANCO"),
    Truck(placa: "142478", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
    Truck(placa: "165873", empresa: "CHATARRERO", marca: "FREIGHTLINER", color: "BLANCO"),
    Truck(placa: "171441", empresa: "PROPIO", marca: "FREIGHTLINER", color: "VERDE"),
    Truck(placa: "171343", empresa: "LUISMAR", marca: "FREIGHTLINER", color: "BLANCO"),
    Truck(placa: "150302", empresa: "SERGIO ROJAS", marca: "INTERNATIONAL", color: "BLANCO"),
    Truck(placa: "146137", empresa: "PROPIO", marca: "FREIGHTLINER", color: "NEGRO"),
    Truck(placa: "160955", empresa: "PROPIO", marca: "FREIGHTLINER", color: "CELESTE"),
    Truck(placa: "174639", empresa: "PROPIO", marca: "KENWORTH", color: "NEGRO"),
    Truck(placa: "145982", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "140348", empresa: "FRANJOR", marca: "KENWORTH", color: "ROJO"),
  Truck(placa: "176231", empresa: "PROPIO", marca: "FREIGHTLINER", color: "ROJO"),
  Truck(placa: "156711", empresa: "PROPIO", marca: "FREIGHTLINER", color: "NEGRO"),
  Truck(placa: "157002", empresa: "MICHAEL MOLINOS", marca: "INTERNATIONAL", color: "GRIS"),
  Truck(placa: "138578", empresa: "PROPIO", marca: "FREIGHTLINER", color: "GRIS"),
  Truck(placa: "168200", empresa: "PROPIO", marca: "FREIGHTLINER", color: "ROJO"),
  Truck(placa: "142522", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "166860", empresa: "PROPIO", marca: "FREIGHTLINER", color: "AMARILLO"),
  Truck(placa: "133983", empresa: "MAURICIO SEGURA", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "135175", empresa: "PROPIO", marca: "KENWORTH", color: "MORADO"),
  Truck(placa: "149013", empresa: "PROPIO", marca: "FREIGHTLINER", color: "AZUL"),
  Truck(placa: "133064", empresa: "CRISTIAN ESPINOZA", marca: "FREIGHTLINER", color: "NEGRO"),
  Truck(placa: "174661", empresa: "CRISTIAN ESPINOZA", marca: "VOLVO", color: "BLANCO"),
  Truck(placa: "177500", empresa: "CHICO CHANCHO", marca: "FREIGHTLINER", color: "VERDE"),
  Truck(placa: "169440", empresa: "CHICO CHANCHO", marca: "KENWORTH", color: "BLANCO"),
  Truck(placa: "162488", empresa: "CHICO CHANCHO", marca: "FREIGHTLINER", color: "NEGRO"),
  Truck(placa: "148974", empresa: "PROPIO", marca: "FREIGHTLINER", color: "AZUL"),
  Truck(placa: "150788", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "135105", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "147117", empresa: "MARCOS CRUZ", marca: "FREIGHTLINER", color: "CAFÉ"),
  Truck(placa: "173594", empresa: "PEROLILLA", marca: "FREIGHTLINER", color: "ROJO"),
  Truck(placa: "151082", empresa: "PEROLILLA", marca: "FREIGHTLINER", color: "AZUL"),
  Truck(placa: "173664", empresa: "PROPIO", marca: "FREIGHTLINER", color: "AMARILLO"),
  Truck(placa: "165329", empresa: "ALLAN GOMEZ", marca: "FREIGHTLINER", color: "GRIS"),
  Truck(placa: "169539", empresa: "ALLAN GOMEZ", marca: "FREIGHTLINER", color: "ROJO"),
  Truck(placa: "146926", empresa: "FABIAN LEON", marca: "FREIGHTLINER", color: "ROJO"),
  Truck(placa: "150359", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "161261", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "142378", empresa: "GERARDO ROJAS", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "163838", empresa: "GERARDO ROJAS", marca: "FREIGHTLINER", color: "CELESTE"),
  Truck(placa: "166106", empresa: "JONATHAN ROJAS", marca: "KENWORTH", color: "BLANCO"),
  Truck(placa: "152083", empresa: "JONATHAN ROJAS", marca: "PETERBILT", color: "VERDE"),
  Truck(placa: "164119", empresa: "JONATHAN ROJAS", marca: "FREIGHTLINER", color: "CELESTE"),
  Truck(placa: "145220", empresa: "MICHAEL MOLINOS", marca: "FREIGHTLINER", color: "ROJO"),
  Truck(placa: "175079", empresa: "PROPIO", marca: "VOLVO", color: "BLANCO"),
  Truck(placa: "143120", empresa: "PROPIO", marca: "WHITE", color: "BLANCO"),
  Truck(placa: "140364", empresa: "DIDIER CEDEÑO", marca: "FREIGHTLINER", color: "AZUL"),
  Truck(placa: "150059", empresa: "DIDIER CEDEÑO", marca: "FREIGHTLINER", color: "VERDE"),
  Truck(placa: "146529", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "147503", empresa: "PROPIO", marca: "FREIGHTLINER", color: "NEGRO"),
  Truck(placa: "148981", empresa: "PROPIO", marca: "FREIGHTLINER", color: "NEGRO"),
  Truck(placa: "156288", empresa: "DIDIER CEDEÑO", marca: "FREIGHTLINER", color: "NEGRO"),
  Truck(placa: "150922", empresa: "PROPIO", marca: "FREIGHTLINER", color: "AZUL"),
  Truck(placa: "164191", empresa: "PROPIO", marca: "FREIGHTLINER", color: "AZUL"),
  Truck(placa: "146889", empresa: "ISAAC VIQUEZ", marca: "FREIGHTLINER", color: "GRIS"),
  Truck(placa: "171031", empresa: "CARLOS GUTIERREZ", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "159130", empresa: "CARLOS GUTIERREZ", marca: "FREIGHTLINER", color: "VINO"),
  Truck(placa: "157481", empresa: "CARLOS GUTIERREZ", marca: "FREIGHTLINER", color: "AZUL"),
  Truck(placa: "169595", empresa: "AMAPOLOS", marca: "VOLVO", color: "BLANCO"),
  Truck(placa: "171081", empresa: "PROPIO", marca: "FREIGHTLINER", color: "GRIS"),
  Truck(placa: "136671", empresa: "PROPIO", marca: "FREIGHTLINER", color: "AZUL"),
  Truck(placa: "156212", empresa: "DESTINOS LA GLORIA", marca: "FREIGHTLINER", color: "AZUL"),
  Truck(placa: "156857", empresa: "ALLEN LEÓN", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "147474", empresa: "PROPIO", marca: "FREIGHTLINER", color: "ROJO"),
  Truck(placa: "163104", empresa: "PROPIO", marca: "FREIGHTLINER", color: "NEGRO"),
  Truck(placa: "158276", empresa: "PROPIO", marca: "FREIGHTLINER", color: "CELESTE"),
  Truck(placa: "154839", empresa: "PROPIO", marca: "FREIGHTLINER", color: "AZUL"),
  Truck(placa: "126779", empresa: "PROPIO", marca: "KENWORTH", color: "VINO"),
  Truck(placa: "154091", empresa: "DESTINOS LA GLORIA", marca: "FREIGHTLINER", color: "ROJO"),
  Truck(placa: "146585", empresa: "DESTINOS LA GLORIA", marca: "MACK", color: "ROJO"),
  Truck(placa: "154718", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "145574", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "153917", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "167317", empresa: "PROPIO", marca: "KENWORTH", color: "GRIS"),
Truck(placa: "155007", empresa: "PROPIO", marca: "KENWORTH", color: "MORADO"),
Truck(placa: "131842", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "144131", empresa: "CARLOS LORÍA", marca: "FREIGHTLINER", color: "ROJO"),
Truck(placa: "160801", empresa: "PROPIO", marca: "FREIGHTLINER", color: "VERDE"),
Truck(placa: "165031", empresa: "PROPIO", marca: "FREIGHTLINER", color: "AZUL"),
Truck(placa: "145140", empresa: "EDGAR RODRIGUEZ", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "154315", empresa: "EDGAR RODRIGUEZ", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "163432", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BEIGE"),
Truck(placa: "165279", empresa: "TRANSALPHER", marca: "PETERBILT", color: "AZUL"),
Truck(placa: "169196", empresa: "TRANSALPHER", marca: "PETERBILT", color: "BLANCO"),
Truck(placa: "164481", empresa: "JAIRO SOLIS", marca: "KENWORTH", color: "VINO"),
Truck(placa: "160385", empresa: "PROPIO", marca: "FREIGHTLINER", color: "VERDE"),
Truck(placa: "155383", empresa: "MORADEL", marca: "FREIGHTLINER", color: "VINO"),
Truck(placa: "162038", empresa: "MORADEL", marca: "FREIGHTLINER", color: "AZUL"),
Truck(placa: "159853", empresa: "MORADEL", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "164737", empresa: "TICOTI", marca: "INTERNATIONAL", color: "BLANCO"),
Truck(placa: "156008", empresa: "HEYDA RAMIREZ", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "152219", empresa: "MUCO", marca: "FREIGHTLINER", color: "ROJO"),
Truck(placa: "149417", empresa: "KEYLOR GARCIA", marca: "FREIGHTLINER", color: "VERDE"),
Truck(placa: "132304", empresa: "LINO GONZALEZ", marca: "PETERBILT", color: "BLANCO"),
Truck(placa: "167477", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "143209", empresa: "PROPIO", marca: "FREIGHTLINER", color: "VERDE"),
Truck(placa: "172218", empresa: "PROPIO", marca: "FREIGHTLINER", color: "CELESTE"),
Truck(placa: "157629", empresa: "PROPIO", marca: "PETERBILT", color: "VINO"),
Truck(placa: "157439", empresa: "PROPIO", marca: "FREIGHTLINER", color: "NEGRO"),
Truck(placa: "133615", empresa: "GRUPO LEON", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "162417", empresa: "GRUPO LEON", marca: "KENWORTH", color: "BLANCO"),
Truck(placa: "147271", empresa: "MAIANGELA FALLAS", marca: "FREIGHTLINER", color: "ROJO"),
Truck(placa: "174285", empresa: "LUIS EMILIO RIVERA", marca: "FREIGHTLINER", color: "ROJO"),
Truck(placa: "150089", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "153409", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "144538", empresa: "PROPIO", marca: "FREIGHTLINER", color: "CELESTE"),
Truck(placa: "163922", empresa: "PROPIO", marca: "FREIGHTLINER", color: "VINO"),
Truck(placa: "124925", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "172273", empresa: "PROPIO", marca: "FREIGHTLINER", color: "VINO"),
Truck(placa: "144255", empresa: "PROPIO", marca: "FREIGHTLINER", color: "AMARILLO"),
  Truck(placa: "144447", empresa: "PROPIO", marca: "FREIGHTLINER", color: "CELESTE"),
  Truck(placa: "160227", empresa: "PROPIO", marca: "FREIGHTLINER", color: "NEGRO"),
  Truck(placa: "156452", empresa: "ISAAC VIQUEZ", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "146120", empresa: "PROPIO", marca: "FREIGHTLINER", color: "AMARILLO"),
  Truck(placa: "138400", empresa: "ADEMAR CANECO", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "169357", empresa: "RODRIGO HERRERA", marca: "KENWORTH", color: "VINO"),
  Truck(placa: "170908", empresa: "FRANK CESPEDES", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "171853", empresa: "FRANK CESPEDES", marca: "FREIGHTLINER", color: "VINO"),
  Truck(placa: "171491", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "164918", empresa: "ANDRES LEON", marca: "FREIGHTLINER", color: "AZUL"),
  Truck(placa: "170322", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "174918", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "151141", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "139255", empresa: "ISAAC VIQUEZ PAPA", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "167052", empresa: "EDGAR SALGUERO", marca: "INTERNATIONAL", color: "BLANCO"),
  Truck(placa: "135663", empresa: "CHUZ DEL PACIFICO", marca: "FREIGHTLINER", color: "AZUL"),
  Truck(placa: "144261", empresa: "PROPIO", marca: "KENWORTH", color: "BLANCO"),
  Truck(placa: "171308", empresa: "PROPIO", marca: "KENWORTH", color: "VINO"),
  Truck(placa: "156518", empresa: "PROPIO", marca: "KENWORTH", color: "BLANCO"),
  Truck(placa: "168099", empresa: "PROPIO", marca: "FREIGHTLINER", color: "DORADO"),
  Truck(placa: "167398", empresa: "JOHANA QUESADA", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "168391", empresa: "MICHAEL MOLINOS", marca: "FREIGHTLINER", color: "AZUL"),
  Truck(placa: "151336", empresa: "PROPIO", marca: "KENWORTH", color: "NEGRO"),
  Truck(placa: "163184", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "144887", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "172623", empresa: "GUSTAVO ACUNA", marca: "MACK", color: "VERDE"),
  Truck(placa: "163115", empresa: "PROPIO", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "172755", empresa: "MOISO", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "158773", empresa: "PROPIO", marca: "FREIGHTLINER", color: "ROJO"),
  Truck(placa: "156098", empresa: "PROPIO", marca: "FREIGHTLINER", color: "NEGRO"),
  Truck(placa: "176795", empresa: "ALONSO QUIROS", marca: "FREIGHTLINER", color: "ROJO"),
  Truck(placa: "164290", empresa: "PROPIO", marca: "MERCEDES BENZ", color: "VERDE"),
  Truck(placa: "154490", empresa: "PROPIO", marca: "INTERNATIONAL", color: "AZUL"),
  Truck(placa: "150001", empresa: "PROPIO", marca: "INTERNATIONAL", color: "BLANCO"),
  Truck(placa: "143322", empresa: "PROPIO", marca: "FREIGHTLINER", color: "VINO"),
  Truck(placa: "164915", empresa: "PROPIO", marca: "FREIGHTLINER", color: "CELESTE"),
  Truck(placa: "124008", empresa: "PROPIO", marca: "INTERNATIONAL", color: "BLANCO"),
  Truck(placa: "156404", empresa: "MARIO SOTO", marca: "KENWORTH", color: "BLANCO"),
  Truck(placa: "144201", empresa: "OMAR CHAVEZ", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "170504", empresa: "", marca: "KENWORTH", color: "DORADO"),
  Truck(placa: "168879", empresa: "", marca: "KENWORTH", color: "ROJO"),
  Truck(placa: "161258", empresa: "", marca: "PETERBILT", color: "VERDE"),
  Truck(placa: "145217", empresa: "", marca: "PETERBILT", color: "BLANCO"),
  Truck(placa: "162698", empresa: "", marca: "PETERBILT", color: "BLANCO"),
  Truck(placa: "163089", empresa: "", marca: "KENWORTH", color: "BLANCO"),
  Truck(placa: "156195", empresa: "", marca: "KENWORTH", color: "VINO"),
  Truck(placa: "162906", empresa: "", marca: "KENWORTH", color: "MORADO"),
  Truck(placa: "160630", empresa: "", marca: "FREIGHTLINER", color: "CAFÉ"),
  Truck(placa: "173739", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "177330", empresa: "", marca: "ISUZU", color: "BLANCO"),
  Truck(placa: "141535", empresa: "", marca: "FREIGHTLINER", color: "VERDE"),
  Truck(placa: "167408", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "167406", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "140808", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "168036", empresa: "", marca: "KENWORTH", color: "BEIGE"),
  Truck(placa: "158110", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "166571", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "151343", empresa: "", marca: "WESTERN STAR", color: "BLANCO"),
  Truck(placa: "169160", empresa: "", marca: "INTERNATIONAL", color: "VERDE"),
  Truck(placa: "177822", empresa: "", marca: "MACK", color: "BLANCO"),
  Truck(placa: "177648", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
  Truck(placa: "173965", empresa: "", marca: "VOLVO", color: "BLANCO"),
  Truck(placa: "173928", empresa: "", marca: "PETERBILT", color: "NEGRO"),
  Truck(placa: "149041", empresa: "", marca: "FREIGHTLINER", color: "CAFÉ"),
  Truck(placa: "148020", empresa: "", marca: "FREIGHTLINER", color: "AZUL"),
  Truck(placa: "138319", empresa: "", marca: "FREIGHTLINER", color: "GRIS"),
  Truck(placa: "159732", empresa: "", marca: "VOLVO", color: "BLANCO"),
  Truck(placa: "166512", empresa: "", marca: "FREIGHTLINER", color: "NEGRO"),
Truck(placa: "134713", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
    Truck(placa: "157196", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
    Truck(placa: "169759", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
    Truck(placa: "175033", empresa: "", marca: "FREIGHTLINER", color: "AZUL"),
    Truck(placa: "139544", empresa: "", marca: "FREIGHTLINER", color: "MORADO"),
    Truck(placa: "178971", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
    Truck(placa: "145319", empresa: "", marca: "FREIGHTLINER", color: "CELESTE"),
    Truck(placa: "166511", empresa: "", marca: "FREIGHTLINER", color: "CREMA"),
    Truck(placa: "141734", empresa: "", marca: "FREIGHTLINER", color: "AZUL"),
    Truck(placa: "149835", empresa: "", marca: "KENWORTH", color: "VINO"),
    Truck(placa: "163053", empresa: "", marca: "INTERNATIONAL", color: "ROJO"),
    Truck(placa: "172874", empresa: "", marca: "KENWORTH", color: "CELESTE"),
    Truck(placa: "144286", empresa: "", marca: "VOLVO", color: "BLANCO"),
    Truck(placa: "138271", empresa: "", marca: "FREIGHTLINER", color: "GRIS"),
    Truck(placa: "148770", empresa: "", marca: "MACK", color: "ROJO"),
    Truck(placa: "169833", empresa: "", marca: "KENWORTH", color: "VINO"),
    Truck(placa: "137082", empresa: "", marca: "FREIGHTLINER", color: "ROJO"),
    Truck(placa: "141140", empresa: "", marca: "FREIGHTLINER", color: "AZUL"),
    Truck(placa: "166248", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
    Truck(placa: "168440", empresa: "", marca: "KENWORTH", color: "AZUL"),
    Truck(placa: "139128", empresa: "", marca: "FREIGHTLINER", color: "VINO"),
    Truck(placa: "152995", empresa: "", marca: "KENWORTH", color: "BLANCO"),
    Truck(placa: "177410", empresa: "", marca: "MACK", color: "VERDE"),
    Truck(placa: "165877", empresa: "", marca: "FREIGHTLINER", color: "NEGRO"),
    Truck(placa: "148442", empresa: "", marca: "FREIGHTLINER", color: "ROJO"),
    Truck(placa: "144118", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
    Truck(placa: "141451", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
    Truck(placa: "142637", empresa: "", marca: "FREIGHTLINER", color: "VINO"),
    Truck(placa: "166719", empresa: "", marca: "FREIGHTLINER", color: "VERDE"),
    Truck(placa: "156078", empresa: "", marca: "FREIGHTLINER", color: "ROJO"),
    Truck(placa: "166959", empresa: "", marca: "FREIGHTLINER", color: "NEGRO"),
    Truck(placa: "159655", empresa: "", marca: "FREIGHTLINER", color: "AZUL"),
Truck(placa: "157441", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "137248", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "139518", empresa: "", marca: "FREIGHTLINER", color: "VERDE"),
Truck(placa: "143942", empresa: "", marca: "FREIGHTLINER", color: "AZUL"),
Truck(placa: "175451", empresa: "", marca: "FREIGHTLINER", color: "AZUL"),
Truck(placa: "145493", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "131053", empresa: "", marca: "FREIGHTLINER", color: "AZUL"),
Truck(placa: "161828", empresa: "", marca: "PETERBILT", color: "ROJO"),
Truck(placa: "159818", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "145696", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "152868", empresa: "", marca: "FREIGHTLINER", color: "CELESTE"),
Truck(placa: "173347", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "158041", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "172390", empresa: "", marca: "HINO", color: "BLANCO"),
Truck(placa: "167380", empresa: "", marca: "FREIGHTLINER", color: "AZUL"),
Truck(placa: "150481", empresa: "", marca: "FREIGHTLINER", color: "VERDE"),
Truck(placa: "172553", empresa: "", marca: "KENWORTH", color: "BLANCO"),
Truck(placa: "168474", empresa: "", marca: "VOLVO", color: "BLANCO"),
Truck(placa: "136582", empresa: "", marca: "FREIGHTLINER", color: "NEGRO"),
Truck(placa: "151910", empresa: "", marca: "INTERNATIONAL", color: "ROJO"),
Truck(placa: "144902", empresa: "", marca: "FREIGHTLINER", color: "AMARILLO"),
Truck(placa: "125222", empresa: "", marca: "FREIGHTLINER", color: "MARRON"),
Truck(placa: "155874", empresa: "", marca: "KENWORTH", color: "NEGRO"),
Truck(placa: "157766", empresa: "", marca: "FREIGHTLINER", color: "ROJO"),
Truck(placa: "134920", empresa: "", marca: "MACK", color: "AMARILLO"),
Truck(placa: "140503", empresa: "", marca: "FREIGHTLINER", color: "CELESTE"),
Truck(placa: "142100", empresa: "", marca: "FREIGHTLINER", color: "AMARILLO"),
Truck(placa: "144308", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "157009", empresa: "", marca: "KENWORTH", color: "MORADO"),
Truck(placa: "146875", empresa: "", marca: "KENWORTH", color: "BLANCO"),
Truck(placa: "150048", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "146715", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "142630", empresa: "", marca: "FREIGHTLINER", color: "AZUL"),
Truck(placa: "152179", empresa: "", marca: "PETERBILT", color: "AMARILLO"),
Truck(placa: "131263", empresa: "", marca: "SCANIA", color: "AMARILLO"),
Truck(placa: "154581", empresa: "", marca: "FREIGHTLINER", color: "AZUL"),
Truck(placa: "176584", empresa: "", marca: "FREIGHTLINER", color: "ROJO"),
Truck(placa: "164042", empresa: "", marca: "FREIGHTLINER", color: "CELESTE"),
Truck(placa: "139175", empresa: "", marca: "FREIGHTLINER", color: "AZUL"),
Truck(placa: "156527", empresa: "", marca: "KENWORTH", color: "VINO"),
Truck(placa: "169321", empresa: "", marca: "VOLVO", color: "BLANCO"),
Truck(placa: "150396", empresa: "", marca: "FREIGHTLINER", color: "AZUL"),
Truck(placa: "154838", empresa: "", marca: "FREIGHTLINER", color: "AZUL"),
Truck(placa: "177745", empresa: "", marca: "FREIGHTLINER", color: "NEGRO"),
Truck(placa: "170671", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "168692", empresa: "", marca: "MITSUBISHI", color: "BLANCO"),
Truck(placa: "140022", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "136188", empresa: "", marca: "KENWORTH", color: "VINO"),
Truck(placa: "159702", empresa: "", marca: "KENWORTH", color: "AZUL"),
Truck(placa: "178390", empresa: "", marca: "MACK", color: "GRIS"),
Truck(placa: "173427", empresa: "", marca: "FREIGHTLINER", color: "NEGRO"),
Truck(placa: "137389", empresa: "", marca: "FREIGHTLINER", color: "ROJO"),
Truck(placa: "141932", empresa: "", marca: "FREIGHTLINER", color: "VERDE"),
Truck(placa: "176080", empresa: "", marca: "MACK", color: "VERDE"),
Truck(placa: "167080", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "141978", empresa: "", marca: "FREIGHTLINER", color: "VINO"),
Truck(placa: "153013", empresa: "", marca: "FREIGHTLINER", color: "AZUL"),
Truck(placa: "149489", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "129652", empresa: "", marca: "FREIGHTLINER", color: "VERDE"),
Truck(placa: "166214", empresa: "", marca: "KENWORTH", color: "BLANCO"),
Truck(placa: "132872", empresa: "", marca: "FREIGHTLINER", color: "ROJO"),
Truck(placa: "142870", empresa: "", marca: "ISUZU", color: "AZUL"),
Truck(placa: "163331", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "166795", empresa: "", marca: "FREIGHTLINER", color: "AZUL"),
Truck(placa: "145334", empresa: "", marca: "KENWORTH", color: "VINO"),
Truck(placa: "168826", empresa: "", marca: "PETERBILT", color: "ROJO"),
Truck(placa: "136620", empresa: "", marca: "FREIGHTLINER", color: "ROJO"),
Truck(placa: "138415", empresa: "", marca: "FREIGHTLINER", color: "ROJO"),
Truck(placa: "175240", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "157285", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
Truck(placa: "142613", empresa: "", marca: "KENWORTH", color: "BLANCO"),
Truck(placa: "138598", empresa: "", marca: "FREIGHTLINER", color: "AMARILLO"),
Truck(placa: "147081", empresa: "", marca: "FREIGHTLINER", color: "AZUL"),
Truck(placa: "165826", empresa: "", marca: "INTERNATIONAL", color: "BLANCO"),
Truck(placa: "155021", empresa: "", marca: "FREIGHTLINER", color: "AZUL"),
    Truck(placa: "143790", empresa: "", marca: "FREIGHTLINER", color: "ROJO"),
    Truck(placa: "176732", empresa: "", marca: "VOLVO", color: "AZUL"),
    Truck(placa: "171126", empresa: "", marca: "FREIGHTLINER", color: "ROJO"),
    Truck(placa: "162816", empresa: "", marca: "FREIGHTLINER", color: "ROJO"),
    Truck(placa: "164733", empresa: "", marca: "FREIGHTLINER", color: "ANARANJADO"),
    Truck(placa: "135988", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
    Truck(placa: "142068", empresa: "", marca: "FREIGHTLINER", color: "CAFÉ"),
    Truck(placa: "141381", empresa: "", marca: "FREIGHTLINER", color: "MORADO"),
    Truck(placa: "166985", empresa: "", marca: "FREIGHTLINER", color: "MORADO"),
    Truck(placa: "133046", empresa: "", marca: "FREIGHTLINER", color: "AZUL"),
    Truck(placa: "157475", empresa: "", marca: "FREIGHTLINER", color: "MORADO"),
    Truck(placa: "173378", empresa: "", marca: "FREIGHTLINER", color: "NEGRO"),
    Truck(placa: "154934", empresa: "", marca: "INTERNATIONAL", color: "VINO"),
    Truck(placa: "156666", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
    Truck(placa: "142419", empresa: "", marca: "KENWORTH", color: "VERDE"),
    Truck(placa: "170812", empresa: "", marca: "VOLVO", color: "NEGRO"),
    Truck(placa: "132963", empresa: "", marca: "FREIGHTLINER", color: "ROJO"),
    Truck(placa: "146791", empresa: "", marca: "FREIGHTLINER", color: "AZUL"),
    Truck(placa: "161972", empresa: "", marca: "VOLVO", color: "AMARILLO"),
    Truck(placa: "148790", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
    Truck(placa: "168045", empresa: "", marca: "FREIGHTLINER", color: "VINO"),
    Truck(placa: "155196", empresa: "", marca: "KENWORTH", color: "VINO"),
    Truck(placa: "154273", empresa: "", marca: "KENWORTH", color: "VINO"),
    Truck(placa: "134866", empresa: "", marca: "FREIGHTLINER", color: "MORADO"),
    Truck(placa: "146601", empresa: "", marca: "FREIGHTLINER", color: "AZUL"),
    Truck(placa: "143788", empresa: "", marca: "FREIGHTLINER", color: "BLANCO"),
    Truck(placa: "171161", empresa: "", marca: "FREIGHTLINER", color: "AZUL"),
    Truck(placa: "151654", empresa: "", marca: "FREIGHTLINER", color: "AMARILLO"),
    Truck(placa: "170065", empresa: "", marca: "FREIGHTLINER", color: "MORADO"),
    Truck(placa: "146697", empresa: "", marca: "INTERNATIONAL", color: "AZUL"),
    Truck(placa: "151221", empresa: "", marca: "INTERNATIONAL", color: "AZUL"),
    Truck(placa: "139514", empresa: "", marca: "KENWORTH", color: "AZUL"),
    Truck(placa: "147962", empresa: "", marca: "FREIGHTLINER", color: "NEGRO"),
    Truck(placa: "138310", empresa: "", marca: "FREIGHTLINER", color: "VERDE"),
];

