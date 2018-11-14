//Request auctions for coin from ebay controller, insert into #results node in page
// Arg: Coin id
function auctions(id) {
	$('#results').load("/ebay?coin_id=" + id,
		function(response, status, xhr) {
			if (status == "error") {
				var msg = "Sorry, but there was an error retrieving the auctions.";
				$("#results").html(msg);
			}
		});
}

