/* Project 16 Source Code~
 * Copyright (C) 2012-2016 sparky4 & pngwen & andrius4669 & joncampbell123 & yakui-lover
 *
 * This file is part of Project 16.
 *
 * Project 16 is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * Project 16 is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>, or
 * write to the Free Software Foundation, Inc., 51 Franklin Street,
 * Fifth Floor, Boston, MA 02110-1301 USA.
 *
 */

#ifndef __SCROLL16_H_
#define __SCROLL16_H_

#include "src/lib/16_head.h"
#include "src/lib/16_tail.h"
#include "src/lib/bakapee.h"
#include "src/lib/16_vl.h"
#include "src/lib/16_in.h"
#include "src/lib/bitmap.h"
#include "src/lib/mapread.h" //map is loaded here www
#include "src/lib/16render.h"
//#include "src/lib/16_map.h"	//new map stuff
#include "src/lib/16_timer.h"
#include "src/lib/wcpu/wcpu.h"

#include <hw/cpu/cpu.h>
#include <hw/dos/dos.h>
#include <hw/vga/vga.h>
#include <hw/vga/vrl.h>

#define SPRITE
//#define TILERENDER

extern void modexDrawSpriteRegion(page_t *page, int x, int y, int rx, int ry, int rw, int rh, bitmap_t *bmp);

//modexDrawSpritePBufRegion
//modexDrawBmpPBufRegion
#define PBUFSFUN		modexDrawSpriteRegion
#define PBUFBFUN		modexDrawBmpRegion
#define PLAYERBMPDATA	player[pn].data

typedef struct {
	map_t *map;
	page_t *page;
	int tx; //appears to be the top left tile position on the viewable screen map
	int ty; //appears to be the top left tile position on the viewable screen map
	word dxThresh; //Threshold for physical tile switch
	word dyThresh; //Threshold for physical tile switch
	video_t *video;	//pointer to game variables of the video
	pan_t *pan;		//pointer the the page panning debug system
	int dx, dy, delta, d;
} map_view_t;
/* Map is presumed to:
 * 1. Have all the required layers and tilesets within itself
 * 2. Have a 'fence' around accessible blocks to simplify boundary logic
 * 3. Have a persistent map and tile size among the layers
 * Map view is presumed to:
 * 1. Calculate, store and update a panning info, which includes, but not limited to:
 * 	combined layer information, actual map representation (reflecting real state of the game),
 * 	pixel shift for smooth tile scrolling.
 * 2. Provide ways to draw a visible part of map. For simplicity with smooth scrolling,
 * 	additional row/column is always drawn at the each side of the map. This implies that 'fence'
 * 	should have a sprite too. Map is drawn left-to-right, top-to-bottom.
 */

typedef struct
{
	map_view_t *mv;
} map_view_db_t;

//for null map!
#define MAPW	40
#define MAPH	30

extern boolean pageflipflop, pageploop;
extern unsigned char shinku_fps_indicator_page;

extern char global_temp_status_text[512];

//map_t allocMap(int w, int h);
//void initMap(map_t *map);
void walk(map_view_t *pip, player_t *player, word pn);
void panpagemanual(map_view_t *pip,  player_t *player, word pn);
void near mapScrollRight(map_view_t *mv, player_t *player, word id, word plid);
void near mapScrollLeft(map_view_t *mv, player_t *player, word id, word plid);
void near mapScrollUp(map_view_t *mv, player_t *player, word id, word plid);
void near mapScrollDown(map_view_t *mv, player_t *player, word id, word plid);
void near ScrollRight(map_view_t *mv, player_t *player, word id, word plid);
void near ScrollLeft(map_view_t *mv, player_t *player, word id, word plid);
void near ScrollUp(map_view_t *mv, player_t *player, word id, word plid);
void near ScrollDown(map_view_t *mv, player_t *player, word id, word plid);
sword chkmap(map_t *map, word q);
void mapGoTo(map_view_t *mv, int tx, int ty);
void near mapDrawTile(tiles_t *t, word i, page_t *page, word x, word y);
void near mapDrawRow(map_view_t *mv, int tx, int ty, word y, player_t *p, word poopoffset);
void near mapDrawCol(map_view_t *mv, int tx, int ty, word x, player_t *p, word poopoffset);
void mapDrawWRow(map_view_t *mv, int tx, int ty, word y);
void mapDrawWCol(map_view_t *mv, int tx, int ty, word x);
//void qclean();
void shinku(global_game_variables_t *gv);
void near animatePlayer(map_view_t *pip, player_t *player, word playnum, sword scrollswitch);

// Move an entity around. Should actually be in 16_entity
boolean ZC_walk(entity_t *ent, map_view_t *map_v);

// Move player around and call map scrolling if required/possible
void walk_player(player_t *player, map_view_t *map_v);

// Scroll map in one direction (assumed from player's movement)
void near mapScroll(map_view_t *mv, player_t *player);

#endif /*__SCROLL16_H_*/