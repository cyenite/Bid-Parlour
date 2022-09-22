class ActiveBids {
  String pair, lastPrice, chg;
  ActiveBids({this.pair, this.lastPrice, this.chg});
}

List<ActiveBids> ActiveBidsList = [
  ActiveBids(pair: "MPESA", lastPrice: "22 Sep 2022", chg: "+114.26%"),
  ActiveBids(pair: "Bank", lastPrice: "22 Sep 2022", chg: "+38.12%"),
  ActiveBids(pair: "MPESA", lastPrice: "23 Sep 2022", chg: "+19.29%"),
  ActiveBids(pair: "MPESA", lastPrice: "25 Sep 2022", chg: "+114.26%"),
  ActiveBids(pair: "Bank", lastPrice: "25 Sep 2022", chg: "+50.12%"),
  ActiveBids(pair: "MPESA", lastPrice: "25 Sep 2022", chg: "+19.29%"),
];
