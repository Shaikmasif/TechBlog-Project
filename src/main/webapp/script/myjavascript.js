
function doLike(pid, uid) {
	console.log("userId:" + uid)
	console.log("postId:" + pid)


	const d = {
		userId: uid,
		postId: pid,
		operation: 'Like'
	}

	$.ajax({
		url: 'likeServlet',
		data: d,
		success: function(data, textStatus, jqXHR) {
			console.log(data)
			if (data.trim() == "true") {
				let c = $(".count-likes").html();
				c++;
				$(".count-likes").html(c);
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
			console.log(data)
		}
	})
}