class ScanModel {
    int id;
    String tipo;
    String valor;

    ScanModel({
        this.id,
        this.tipo,
        this.valor,
    }){
      //Aqui se determnina automaticamente
      if(this.valor.contains('http')){ //----> Si el valor contiene 'http'
        this.tipo = 'http'; //Abre pagina web
      }else{
        this.tipo = 'geo'; //Mapa
      }
    }

    factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id    : json["id"],
        tipo  : json["tipo"],
        valor : json["valor"],
    );

    Map<String, dynamic> toJson() => {
        "id"    : id,
        "tipo"  : tipo,
        "valor" : valor,
    };
}