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

#include "weeterm.h"
#include "weetermint.h"

#include <stdlib.h>
#include <string.h>

int wee_terminal_attr_init(wee_terminal_attr_t *attr)
{
	attr->scrollback = 100;
	attr->rows = 10;
	attr->cols = 80;
	attr->auto_scroll = 1;

	return 0;
}

int wee_terminal_attr_create(wee_terminal_attr_t *attrp)
{
	wee_terminal_attr_t *attr;

	if(attrp == NULL)
		return WEE_EINVAL;

	attr = (wee_terminal_attr_t *)malloc(sizeof(wee_terminal_attr_t));
	if(attr == NULL)
		return WEE_ENOMEM;

	return 0;
}

int wee_terminal_attr_delete(wee_terminal_attr_t *attr)
{
	if(attr == NULL)
		return WEE_EINVAL;
	free(attr);
	return 0;
}

int wee_terminal_create(wee_terminal_t **termp, wee_terminal_attr_t *attr)
{
	wee_terminal_t *term;

	if(termp == NULL)
		return WEE_EINVAL;

	term = (wee_terminal_t *)malloc(sizeof(wee_terminal_t));
	if(term == NULL)
		return WEE_ENOMEM; 

	if(attr == NULL)
	{
		wee_terminal_attr_init(&(term->attr));
	} else {
		memcpy(&(term->attr), attr, sizeof(wee_terminal_attr_t));
	}

	term->bufsz = (term->attr.rows+term->attr.scrollback)*(term->attr.cols+1);
	term->buffer = (char *)malloc(term->bufsz);
	if(term->buffer == NULL)
	{
		free(term);
		return WEE_ENOMEM;
	}
	memset(term->buffer, 0, term->bufsz);

	term->pos = 0;
	term->start = 0;
	term->end = 0;
	term->write_pos = 0;
	return 0;
}

int wee_terminal_delete(wee_terminal_t *term)
{

	free(term->buffer);
	free(term);
	return 0;
}

#define TERM_TOTAL_ROWS (term->attr.rows + term->attr.scrollback)

#define DO_NEWLINE() do { \
	term->end = ++term->end % (term->attr.rows+term->attr.scrollback); \
	if(term->end >= term->start)										\
   		term->start = (term->end+1)	% (term->attr.rows+term->attr.scrollback); \
	term->write_pos = term->end * (term->attr.cols+1); \
} while(0)

int	wee_terminal_print(wee_terminal_t *term, char *str)
{
	int len, i,j;

	if(term == NULL || str == NULL)
		return WEE_EINVAL;

	len = strlen(str);

	if(len > term->bufsz)
		return WEE_EINVAL;

	/* Have to copy byte by byte to scan for \n */
	for(;str;str++)
	{
		/* Is this an actual newline? */
		if(*str == '\n')
		{
			DO_NEWLINE();	
			continue;
		}

		/* Are we wrapping because we hit EOL? */
		if(term->write_pos % (term->attr.cols+1) == 0)
		{
			DO_NEWLINE();
		}
			
		term->buffer[term->write_pos++] = *str;	
	}

	if(term->attr.auto_scroll) {
		wee_terminal_scroll_to_bottom(term);
	}

	return WEE_OK;

}	

int wee_terminal_clear(wee_terminal_t *term)
{
	int i;
	if(term==NULL)
		return WEE_EINVAL;	

	for(i=0;i<term->attr.rows;i++)
	{
		DO_NEWLINE();
		term->buffer[term->write_pos] = '\0';
	}
	DO_NEWLINE();

	return 0;
}

#define BUFF_SZ ((term->start-term->end==1)?TERM_TOTAL_ROWS:term->end-term->start)

int wee_terminal_scroll_up(wee_terminal_t *term)
{ 
	if(term==NULL)
		return WEE_EINVAL;

	if(term->pos == term->start)
		return -1;

	if(term->start < term->end)
	{
		if(term->pos > term->start)
			term->pos--;
		return 0;	
	} else {
		if(--term->pos < 0)
			term->pos+= TERM_TOTAL_ROWS;
		return 0;

	}

}

int wee_terminal_scroll_down(wee_terminal_t *term)
{ 
	if(term==NULL)
		return WEE_EINVAL;

	if(term->pos == term->end)
		return -1;

	if(term->start < term->end)
	{
		if(term->pos < term->end)
			term->pos++;
	} else {
		if (term->pos >= term->start) {
			if(++term->pos > TERM_TOTAL_ROWS)
				term->pos-= TERM_TOTAL_ROWS;
		} else if (term->pos < term->end) { 
			term->pos++;
		}
	}
	return 0;

}

int wee_terminal_scroll_to_bottom(wee_terminal_t *term)
{
	if(term->start < term->end)
	{
		if(term->end - term->start < term->attr.rows)
			term->pos = term->start;
		else
			term->pos = term->end - term->attr.rows;
	} else {
		term->pos = term->end - term->attr.rows;
		if(term->pos < 0)
			term->pos += TERM_TOTAL_ROWS;
	}
	return 0;
}

int wee_terminal_scroll_to_top(wee_terminal_t *term)
{
	term->pos = term->start;
	return 0;
}

int wee_terminal_set_auto_scroll(wee_terminal_t *term, int enabled)
{
	term->attr.auto_scroll = enabled;
	return 0;
}

int wee_terminal_get_lines(wee_terminal_t *term, char *data, int *datalen)
{
	int i=0,j=0;
	if(term == NULL)
		return WEE_EINVAL;

	if(*datalen < (term->attr.cols+1) * term->attr.rows) 
	{
		*datalen = ((term->attr.cols+1)*term->attr.rows);
		return WEE_EINVAL;
	}
	for(j=0,i=term->pos;j<term->attr.rows;i=((i+1)%TERM_TOTAL_ROWS),j+=(term->attr.cols+1))
	{
		memcpy(&(data[j]), &(term->buffer[i*term->attr.cols+1]), term->attr.cols);
	}

	return 0;
}
