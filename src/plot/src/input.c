#include <stdio.h>
#include <string.h>
#include "util.h"
#include "plot.h"
#include "input.h"

#define DEF_BUFFER_SIZE 256
#define TMP_ARR_SIZE 64

static double *tmp_arr = NULL;
static size_t buf_ini_size;

void input_init(void)
{
	buf_ini_size = DEF_BUFFER_SIZE;
	tmp_arr = safe_calloc(TMP_ARR_SIZE, sizeof(double));
}

void set_input_buffer_size(size_t new_size)
{
	buf_ini_size = new_size;
}

void input_cleanup(void)
{
	free(tmp_arr);
}

static int read_numbers(struct input *in, double **dest, size_t max)
{
	char *endptr = NULL;
	size_t i, read;
	size_t len = 0, lr;

	if (in->buf == NULL) {
		in->size = buf_ini_size;
		in->buf = safe_calloc(in->size, sizeof(char));
	} else if (in->rem >= in->size) {
		in->size += in->rem;
		in->buf = safe_realloc(in->buf, sizeof(char) * in->size);
	}

	read = fread(&in->buf[in->rem], sizeof(char), in->size - in->rem, in->src);
	read += in->rem;

	for (i = 0; i < read; i++) {
		if (!is_digit(in->buf[i]) || (endptr != NULL && &in->buf[i] < endptr))
			continue;

		lr = i;
		tmp_arr[len] = strtod(&in->buf[i], &endptr);
		(len)++;

		if (len == max)
			break;
	}

	if (!feof(in->src) && endptr >= &in->buf[i - 1]) {
		in->rem = read - lr;
		in->buf = memmove(in->buf, &in->buf[lr], sizeof(char) * in->rem);
		len--;
	} else {
		in->rem = 0;
	}

	*dest = tmp_arr;
	return len;
}

static void *shift_arr(double *arr, size_t off, size_t amnt)
{
	return memmove(arr, arr + off, sizeof(double) * (amnt));
}

int pdtry_buffer(struct plot_data *pd, size_t max_w, int shift)
{
	size_t len;
	double *arr;

	if (!shift && pd->len >= max_w)
		return 0;

	if ((len = read_numbers(pd->src, &arr, TMP_ARR_SIZE)) == 0)
		return 0;

	if (len >= max_w) {
		if (shift)
			memcpy(pd->data, &arr[len - max_w], max_w * sizeof(double));
		else
			memcpy(pd->data, arr, max_w * sizeof(double));

		pd->len = max_w;
		return 1;
	}

	if (len + pd->len > max_w) {
		if (shift) {
			shift = max_w - pd->len + len;
			pd->data = shift_arr(pd->data, shift, pd->len - shift);
			pd->len = pd->len - shift;

			shift = 1;
		} else {
			len = max_w - pd->len;
		}
	}

	memcpy(&pd->data[pd->len], arr, sizeof(double) * len);
	pd->len += len;
	return 1;
}

int pdtry_all_buffers(struct plot *p, int shift)
{
	size_t i;
	int ret = 0;

	for (i = 0; i < p->datasets; i++)
		ret |= pdtry_buffer(p->data[i], p->width, shift);

	return ret;
}

void pdread_all_available(struct plot *p)
{
	while (pdtry_all_buffers(p, 0));
}
