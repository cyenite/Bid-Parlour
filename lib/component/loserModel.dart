class PastBids {
  String pair, lastPrice, chg;
  PastBids({this.pair, this.lastPrice, this.chg});
}

List<PastBids> PastBidsList = [
  PastBids(pair: "MPESA", lastPrice: "22 Sep 2022", chg: "+114.26%"),
  PastBids(pair: "Bank Transfer", lastPrice: "22 Sep 2022", chg: "+38.12%"),
  PastBids(pair: "MPESA", lastPrice: "23 Sep 2022", chg: "+19.29%"),
  PastBids(pair: "MPESA", lastPrice: "25 Sep 2022", chg: "+114.26%"),
  PastBids(pair: "Bank Transfer", lastPrice: "25 Sep 2022", chg: "+50.12%"),
  PastBids(pair: "MPESA", lastPrice: "25 Sep 2022", chg: "+19.29%"),
];
