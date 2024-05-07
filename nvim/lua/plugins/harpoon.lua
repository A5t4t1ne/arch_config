return {
 	{
 		"ThePrimeagen/harpoon",
 		branch = "harpoon2",
 		dependencies = { "nvim-lua/plenary.nvim" },
 		lazy=false,
		config = true,
 		keys = {
 			{ 
 				"<leader>hm", 
				"<cmd>lua require('harpoon.mark').add_file()<cr>",
 				desc = "Harpoon mark file",
 			},
 			{ 
 				"<leader>hn", 
 				"<cmd>lua require('harpoon.ui').nav_next()<cr>", 
 				desc = "Go to next harpoon mark" 
 			},
 			{ 
 				"<leader>hp", 
 				"<cmd>lua require('harpoon.ui').nav_prev()<cr>", 
 				desc = "Go to previous harpoon mark" },
 			},
 		},
 	}


