class assetsWallet {
  String icon, amount, status, priceValue;
  assetsWallet({this.icon, this.amount, this.status, this.priceValue});
}

List<assetsWallet> assetsWalletList = [
  assetsWallet(
    amount: "220",
    status: "Complete",
  ),
  assetsWallet(
    amount: "5000",
    status: "Pending",
  ),
  assetsWallet(
    amount: "2000",
    status: "Complete",
  ),
];
