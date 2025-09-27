extends Node2D

func _ready() -> void:
	var tileset_resource: TileSet = preload("res://level/compatibility/tiles/tileset.tres")
	var atlas_source: TileSetAtlasSource = tileset_resource.get_source(1)
	
	for casevar: int in range (745):
		var X: int = casevar % 16
		var Y: int = casevar >> 4
		var polygon: PackedVector2Array
		
		if (casevar == 101 || (casevar>=103 && casevar<107) || casevar == 117 || casevar == 118 || casevar == 121 || casevar == 122 || casevar == 129 || casevar == 130 || casevar == 133 || casevar == 134 || casevar == 135 || casevar == 136 || casevar == 201 || casevar == 210 || casevar == 228 || casevar == 237 || casevar == 246 || casevar == 251 || casevar == 260 || casevar == 265 || casevar == 270 || casevar == 275 || casevar == 280 || (casevar>=285 && casevar<=296 && casevar != 293) || casevar == 301 || (casevar>=303 && casevar<307) || casevar == 317 || casevar == 318 || casevar == 321 || casevar == 322 || casevar == 329 || casevar == 330 || casevar == 333 || casevar == 334 || casevar == 351 || casevar == 353 || casevar == 354 || casevar == 397 || casevar == 401 || casevar == 403 || casevar == 404 || casevar == 405 || casevar == 406 || casevar == 417 || casevar == 418 || casevar == 421 || casevar == 422 || casevar == 433 || casevar == 434 || casevar == 443 || casevar == 444 || casevar == 453 || casevar == 454 || casevar == 459 || casevar == 460 || casevar == 470 || casevar == 473 || casevar == 476 || casevar == 479 || casevar == 485 || casevar == 486 || casevar == 491 || casevar == 495 || casevar == 501 || casevar == 514 || casevar == 527 || casevar == 538 || casevar == 539 || casevar == 551 || casevar == 564 || casevar == 571 || casevar == 576 || casevar == 581 || casevar == 586 || casevar == 593 || casevar == 594 || casevar == 437 || casevar == 438 || casevar == 443 || casevar == 444 || casevar == 601 || casevar == 622 || casevar == 629 || casevar == 636 || casevar == 637 || casevar == 638 || casevar == 645 || casevar == 650 || casevar == 651 || casevar == 656 || casevar == 672 || casevar == 677 || casevar == 682 || casevar == 690 || casevar == 695 || casevar == 705 || casevar == 706 || casevar == 715 || casevar == 720 || casevar == 725 || casevar == 732 || casevar == 733 || casevar == 734 || casevar == 736 || casevar == 737 || casevar == 429 || casevar == 430 || casevar == 482 || casevar == 739 || casevar == 740):
			# Tiles in Front GFX that are the 32x32
			# .....
			# .....
			# .....
			
			polygon.append(Vector2(0-32, 0-32))
			polygon.append(Vector2(0, 0-32))
			polygon.append(Vector2(0, 0))
			polygon.append(Vector2(0-32, 0))
			polygon.append(Vector2(0-32, 0-32))
			#
		elif (casevar == 102 || casevar == 202 || casevar == 211 || casevar == 220 || casevar == 229 || casevar == 238 || casevar == 247 || casevar == 252 || casevar == 261 || casevar == 266 || casevar == 271 || casevar == 276 || casevar == 281 || casevar == 302 || casevar == 352 || casevar == 402 || casevar == 472 || casevar == 475 || casevar == 478 || casevar == 481 || casevar == 484 || casevar == 487 || casevar == 491 || casevar == 502 || casevar == 515 || casevar == 528 || casevar == 540 || casevar == 552 || casevar == 565 || casevar == 572 || casevar == 577 || casevar == 582 || casevar == 587 || casevar == 595 || casevar == 602 || casevar == 623 || casevar == 630 || casevar == 646 || casevar == 652 || casevar == 657 || casevar == 673 || casevar == 678 || casevar == 683 || casevar == 691 || casevar == 696 || casevar == 701 || casevar == 707 || casevar == 716 || casevar == 721 || casevar == 726 || casevar == 741):
			# 
			# .....
			# .....
			
			polygon.append(Vector2(0-32, 0-16))
			polygon.append(Vector2(0, 0-16))
			polygon.append(Vector2(0, 0))
			polygon.append(Vector2(0-32, 0))
			polygon.append(Vector2(0-32, 0-16))
			#
		elif (casevar == 137 || casevar == 203 || casevar == 212 || casevar == 221 || casevar == 230 || casevar == 239 || casevar == 248 || casevar == 253 || casevar == 262 || casevar == 267 || casevar == 272 || casevar == 277 || casevar == 282 || casevar == 337 || casevar == 375 || casevar == 461 || casevar == 471 || casevar == 474 || casevar == 477 || casevar == 480 || casevar == 483 || casevar == 488 || casevar == 492 || casevar == 503 || casevar == 516 || casevar == 529 || casevar == 541 || casevar == 553 || casevar == 566 || casevar == 573 || casevar == 578 || casevar == 583 || casevar == 588 || casevar == 596 || casevar == 603 || casevar == 624 || casevar == 631 || casevar == 647 || casevar == 653 || casevar == 658 || casevar == 674 || casevar == 679 || casevar == 684 || casevar == 692 || casevar == 697 || casevar == 702 || casevar == 708 || casevar == 717 || casevar == 722 || casevar == 727 || casevar == 742):
			# .....
			# .....
			#      
			
			polygon.append(Vector2(0-32, 0-32))
			polygon.append(Vector2(0, 0-32))
			polygon.append(Vector2(0, 0-16))
			polygon.append(Vector2(0-32, 0-16))
			polygon.append(Vector2(0-32, 0-32))
			#
		elif (casevar == 107 || casevar == 109 || casevar == 115 || casevar == 307 || casevar == 309 || casevar == 315 || casevar == 335 || casevar == 370 || casevar == 407 || casevar == 409 || casevar == 413 || casevar == 415 || casevar == 547):
			#   ...
			#   ...
			#   ...
			
			polygon.append(Vector2(0-32+16, 0-32))
			polygon.append(Vector2(0, 0-32))
			polygon.append(Vector2(0, 0))
			polygon.append(Vector2(0-32+16, 0))
			polygon.append(Vector2(0-32+16, 0-32))
			#
		elif (casevar == 108 || casevar == 110 || casevar == 116 || casevar == 308 || casevar == 310 || casevar == 316 || casevar == 336 || casevar == 369 || casevar == 408 || casevar == 410 || casevar == 414 || casevar == 416 || casevar == 546):
			# ...   
			# ...   
			# ...   
			
			polygon.append(Vector2(0-32, 0-32))
			polygon.append(Vector2(0-16, 0-32))
			polygon.append(Vector2(0-16, 0))
			polygon.append(Vector2(0-32, 0))
			polygon.append(Vector2(0-32, 0-32))
			#
		elif (casevar == 204 || casevar == 213 || casevar == 222 || casevar == 231 || casevar == 240 || casevar == 249 || casevar == 254 || casevar == 263 || casevar == 268 || casevar == 273 || casevar == 278 || casevar == 283 || casevar == 489 || casevar == 494 || casevar == 504 || casevar == 517 || casevar == 530 || casevar == 554 || casevar == 567 || casevar == 570 || casevar == 574 || casevar == 579 || casevar == 585 || casevar == 597 || casevar == 436 || casevar == 604 || casevar == 625 || casevar == 632 || casevar == 648 || casevar == 654 || casevar == 659 || casevar == 675 || casevar == 680 || casevar == 685 || casevar == 693 || casevar == 698 || casevar == 703 || casevar == 709 || casevar == 718 || casevar == 723 || casevar == 728 || casevar == 436 || casevar == 743):
			# .
			# ...
			# .....
			
			polygon.append(Vector2(0-32, 0-32))
			polygon.append(Vector2(0, 0))
			polygon.append(Vector2(0-32, 0))
			polygon.append(Vector2(0-32, 0-32))
			#
		elif (casevar == 205 || casevar == 214 || casevar == 223 || casevar == 232 || casevar == 241 || casevar == 250 || casevar == 255 || casevar == 264 || casevar == 274 || casevar == 269 || casevar == 274 || casevar == 279 || casevar == 284 || casevar == 490 || casevar == 493 || casevar == 505 || casevar == 518 || casevar == 531 || casevar == 555 || casevar == 568 || casevar == 569 || casevar == 575 || casevar == 580 || casevar == 584 || casevar == 598 || casevar == 435 || casevar == 605 || casevar == 626 || casevar == 633 || casevar == 649 || casevar == 655 || casevar == 660 || casevar == 676 || casevar == 681 || casevar == 686 || casevar == 694 || casevar == 699 || casevar == 704 || casevar == 710 || casevar == 719 || casevar == 724 || casevar == 729 || casevar == 435 || casevar == 744):
			#     .
			#   ...
			# .....
			
			polygon.append(Vector2(0, 0-32))
			polygon.append(Vector2(0, 0))
			polygon.append(Vector2(0-32, 0))
			polygon.append(Vector2(0, 0-32))
			#
		elif (casevar == 127 || casevar == 131 || casevar == 206 || casevar == 215 || casevar == 224 || casevar == 233 || casevar == 242 || casevar == 256 || casevar == 327 || casevar == 331 || casevar == 358 || casevar == 366 || casevar == 427 || casevar == 431 || casevar == 506 || casevar == 519 || casevar == 532 || casevar == 556 || casevar == 427 || casevar == 431 || casevar == 711):
			#     
			#    ..
			# .....
			
			polygon.append(Vector2(0, 0-32+16))
			polygon.append(Vector2(0, 0))
			polygon.append(Vector2(0-32, 0))
			polygon.append(Vector2(0, 0-32+16))
			#
		elif (casevar == 128 || casevar == 132 || casevar == 207 || casevar == 216 || casevar == 225 || casevar == 234 || casevar == 243 || casevar == 257 || casevar == 328 || casevar == 332 || casevar == 357 || casevar == 365 || casevar == 428 || casevar == 432 || casevar == 507 || casevar == 520 || casevar == 533 || casevar == 557 || casevar == 428 || casevar == 432 || casevar == 712):
			#     
			# ..   
			# .....
			
			polygon.append(Vector2(0-32, 0-32+16))
			polygon.append(Vector2(0, 0))
			polygon.append(Vector2(0-32, 0))
			polygon.append(Vector2(0-32, 0-32+16))

			#
		elif (casevar == 123 || casevar == 125 || casevar == 208 || casevar == 217 || casevar == 226 || casevar == 235 || casevar == 244 || casevar == 253 || casevar == 258 || casevar == 323 || casevar == 325 || casevar == 356 || casevar == 364 || casevar == 423 || casevar == 425 || casevar == 508 || casevar == 521 || casevar == 534 || casevar == 558 || casevar == 423 || casevar == 425 || casevar == 713):
			#    ..   
			# .....   
			# .....
			
			polygon.append(Vector2(0-32, 0-32+16))
			polygon.append(Vector2(0, 0-32))
			polygon.append(Vector2(0, 0))
			polygon.append(Vector2(0-32, 0))
			polygon.append(Vector2(0-32, 0-32+16))

			#
		elif (casevar == 124 || casevar == 126 || casevar == 209 || casevar == 218 || casevar == 227 || casevar == 236 || casevar == 245 || casevar == 259 || casevar == 260 || casevar == 324 || casevar == 326 || casevar == 355 || casevar == 363 || casevar == 424 || casevar == 426 || casevar == 509 || casevar == 522 || casevar == 535 || casevar == 559 || casevar == 424 || casevar == 426 || casevar == 714):
			# ..   
			# .....   
			# .....
			
			polygon.append(Vector2(0-32, 0-32))
			polygon.append(Vector2(0, 0-32+16))
			polygon.append(Vector2(0, 0))
			polygon.append(Vector2(0-32, 0))
			polygon.append(Vector2(0-32, 0-32))

			#
		elif (casevar == 111 || casevar == 113 || casevar == 311 || casevar == 313 || casevar == 544 || casevar == 591):
			#      
			#   ...
			#   ...
			
			polygon.append(Vector2(0-32+16, 0-32+16))
			polygon.append(Vector2(0, 0-32+16))
			polygon.append(Vector2(0, 0))
			polygon.append(Vector2(0-32+16, 0))
			polygon.append(Vector2(0-32+16, 0-32+16))

			#
		elif (casevar == 112 || casevar == 114 || casevar == 312 || casevar == 314 || casevar == 545 || casevar == 592):
			#       
			# ...  
			# ...  
			
			polygon.append(Vector2(0-32, 0-32+16))
			polygon.append(Vector2(0-16, 0-32+16))
			polygon.append(Vector2(0-16, 0))
			polygon.append(Vector2(0-32, 0))
			polygon.append(Vector2(0-32, 0-32+16))

		elif (casevar == 181):
			#
			
			polygon.append(Vector2(0-32, 0-16))
			polygon.append(Vector2(0, 0-16))
			polygon.append(Vector2(0, 0))
			polygon.append(Vector2(0-32, 0))
			polygon.append(Vector2(0-32, 0-16))

		
		if ((casevar>=470 && casevar<=485) || (casevar>=435 && casevar<=442) || (casevar>=156 && casevar<=160)):
			polygon.append(Vector2(0-32, 0-32))
			polygon.append(Vector2(0, 0-32))
			polygon.append(Vector2(0, 0))
			polygon.append(Vector2(0-32, 0))
			polygon.append(Vector2(0-32, 0-32))
		
		#if (casevar == 536):
			#
			#polygon.append(Vector2(0-32, 0-16))
			#polygon.append(Vector2(0, 0-16))
			#polygon.append(Vector2(0, 0))
			#polygon.append(Vector2(0-32, 0))
			#polygon.append(Vector2(0-32, 0-16))
#
			##
			#_root.Course.Lava.beginFill(0x00FF00)
			#_root.Course.Lava.moveTo(0-32, 0-32)
			#_root.Course.Lava.lineTo(0, 0-32)
			#_root.Course.Lava.lineTo(0, 0)
			#_root.Course.Lava.lineTo(0-32, 0)
			#_root.Course.Lava.lineTo(0-32, 0-32)
			#_root.Course.Lava.endFill()
			##
		#
		#if (casevar == 537):
			#
			#polygon.append(Vector2(0-32, 0-32))
			#polygon.append(Vector2(0, 0-32))
			#polygon.append(Vector2(0, 0))
			#polygon.append(Vector2(0-32, 0))
			#polygon.append(Vector2(0-32, 0-32))
#
			##
			#_root.Course.Lava.beginFill(0x00FF00)
			#_root.Course.Lava.moveTo(0-32, 0-32)
			#_root.Course.Lava.lineTo(0, 0-32)
			#_root.Course.Lava.lineTo(0, 0)
			#_root.Course.Lava.lineTo(0-32, 0)
			#_root.Course.Lava.lineTo(0-32, 0-32)
			#_root.Course.Lava.endFill()
		
		#var polygon_node := Polygon2D.new()
		#polygon_node.polygon = polygon
		#polygon_node.position.x = X * 48
		#polygon_node.position.y = Y * 48
		#add_child(polygon_node)
		
		if not polygon.is_empty():
			for index in range(polygon.size()):
				polygon[index] = polygon[index] + Vector2(16, 16)
			atlas_source.set("%s:%s/0/physics_layer_0/polygon_0/points" % [X, Y], polygon)
	
	tileset_resource.remove_source(1)
	tileset_resource.add_source(atlas_source)
	ResourceSaver.save(tileset_resource, "res://level/compatibility/tiles/generated_tileset.tres")
