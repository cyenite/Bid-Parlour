class newsListBottom {
  String img, title, author, desc1, desc2, desc3, time, id;

  newsListBottom(
      {this.img,
      this.title,
      this.author,
      this.desc1,
      this.desc2,
      this.desc3,
      this.time,
      this.id});
}

List<newsListBottom> newsList = [
  newsListBottom(
      id: "7",
      img: "assets/image/News_Image/MarketSentiment.jpg",
      title: "Market Sentiment: Positivity Among Top Coins Is Taking Over",
      author: "By Sead Fadilpašić",
      time: "Yesterday",
      desc1:
          "Out of the top 10 coins by market capitalization, six are above the negative line in terms of market sentiment, while one is in the neutral waters, according to Predicoin, a crypto market sentiment data analysis service. The average score comes up to 5.41, an improvement compared to last week (5.02.)\n\nMoreover, the market is in green today. Bitcoin just broke the USD 3.900 level (UTC 4:40 AM,) last time seen on January 10, while ether surpassed USD 146 and other top coins are registering gains of 6% - 22% in the past 24 hours.",
      desc2:
          "Part of the improved sentiment surrounding Stellar comes possibly from its Stellar v10.2.0 release, which introduced many new stabilizing elements and added new technical features, launched on February 14th. However, the sentiment around the coin is still negative at 4.6 compared to last week’s 3.6.\n\nBitcoin Cash’s high weekly improvement score is also a surprise compared to last week, when it was the fastest dropping coin by sentiment score out of the top 10 - but it’s still far from winning, given that it now scored 4.6 total.\n\nAs of Monday (UTC 10:28 am), the clear winners of the week are Ethereum , Litecoin , Bitcoin and EOS. In the more neutral range are Binance Coin, Tether, and TRON, although the fact that their scores are not below 5 could arguably mean they are winners as well. Tether and TRON are newcomers compared to last week, when Bitcoin, Ethereum, Litecoin, EOS, and Binance Coin were the only ones on the winning list.",
      desc3:
          "The company has previously gone public in Canada, starting trading on the Toronto Venture Exchange (TSX-V) under the ticker VYGR, as a result of a reverse merger reportedly valued at USD 60 million. Ehrlich said that the decision to go public is set to bring a higher level of trust from customers, adding, “By becoming a publicly traded entity, Voyager allows the traditional investing community to tap the public markets for exposure to this important asset class and financial utility that is built upon the technology of the future [...] This type of exposure will help more people become comfortable with the crypto market and ultimately increase widespread adoption.”"),
];
