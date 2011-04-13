/*
   Copyright (c) 2011 Workshop 88

This software is provided 'as-is', without any express or implied
warranty. In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

1. The origin of this software must not be misrepresented; you must not
claim that you wrote the original software. If you use this software
in a product, an acknowledgment in the product documentation would be
appreciated but is not required.

2. Altered source versions must be plainly marked as such, and must not be
misrepresented as being the original software.

3. This notice may not be removed or altered from any source
distribution.

*/

#ifndef _WEETERM_H
#define _WEETERM_H

#define WEE_OK		 0
#define WEE_ERR		-1
#define WEE_ENOMEM	-2
#define WEE_EINVAL	-3

/*! \brief Attributes used when creating a terminal 
 */
typedef struct wee_terminal_attr_t_stct {
	/*! Number of rows to save above current top row (default is 100) */
	int scrollback;
	/*! Number of rows in the display (default is 10) */
	int rows;
	/*! Number of columns in the display (default is 80) */
	int cols;
	/*! Whether the display should scroll to the bottom when a new line
	  	is added (default is 1) */
	int auto_scroll;
} wee_terminal_attr_t;

/*! \brief Opaque type to represent a terminal 
 */
struct wee_terminal_t_stct;
typedef struct wee_terminal_t_stct wee_terminal_t;


/*! \brief Initialize an attributes struct allocated by the user with the defaults */
int wee_termainl_attr_init(wee_terminal_attr_t *attr);

/*! \brief Allocate a new attributes struct, and set its values to the defaults */
int wee_terminal_attr_create(wee_terminal_attr_t **attrp);

/*! \brief Deallocate an attributes struct previously allocated with \see wee_terminal_attr_create */
int wee_terminal_attr_delete(wee_terminal_attr_t *attr);

/*! \brief Create a new terminal with the settings specified in the attributes object.
	\param termp A pointer to a pointer that will be filled in when this function returns.
	\param attr A pointer to an attributes object containing configuration options for the
				new terminal.  Specify NULL to use the defaults.
 */
int wee_terminal_create(wee_terminal_t **termp, wee_terminal_attr_t *attr);
/*! \brief Delete a terminal allocated with \see wee_terminal_create */
int wee_terminal_delete(wee_terminal_t *term);

/*! \brief Write data to the terminal.  Writing \n will cause the terminal to
			begin a new line.  If a line is too long to be written to a single
			terminal line, it will wrap to the next line without consideration 
			for the content of the text being written. */
int wee_terminal_print(wee_terminal_t *term, char *str);

/*! \brief Clear the current display buffer.
  	This has the effect of writing out enough newlines to scroll the buffer by 
	the number of rows in the display buffer
*/
int wee_terminal_clear(wee_terminal_t *term);

/*! \brief Scroll the up one row*/
int wee_terminal_scroll_up(wee_terminal_t *term);

/*! \brief Scroll the down one row*/
int wee_terminal_scroll_down(wee_terminal_t *term);

/*! \brief Scroll the terminal to the beginning of the scrollback buffer */
int wee_terminal_scroll_to_top(wee_terminal_t *term);

/*! \brief Scroll the terminal to the end of the scrollback buffer */
int wee_terminal_scroll_to_bottom(wee_terminal_t *term);

/*! \brief Enable or disable automatic scrolling on output */
int wee_terminal_set_auto_scroll(wee_terminal_t *term, int enabled);

/*! \brief Returns the lines currently within the display area 
 	\param data The memory location pointed to by data must be
			large enough to hold a full display of data, as 
			configured when the terminal was created.
	\param datalen The length of the memory location pointed to
			by data.  If the block of memory is too small, this
			function will return -1, and set the size of datalen
			to the required size.
 */
int wee_terminal_get_lines(wee_terminal_t *term, char *data, int *datalen);

#endif /* _WEETERM_H */
