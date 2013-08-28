DESTDIR = .
BOARDS = p2041rdb p3041ds p4080ds p5020ds p5040ds b4860qds t4240qds b4420qds \
	 t1040rdb t1040qds
VER = $(shell git describe --tags)

all install clean:
	@for board in $(BOARDS); do \
		$(MAKE) -C $$board $@ DESTDIR=$(DESTDIR)/$$board; \
	done

release: $(foreach board,$(BOARDS),rcw-$(board)-$(VER).tar.gz)

$(foreach board,$(BOARDS),rcw-$(board)-$(VER).tar.gz): rcw-%-$(VER).tar.gz:
	git archive --format=tar HEAD --prefix rcw- $* | gzip -9 > $@

.PHONY: all install clean release $(foreach board,$(BOARDS),rcw-$(board)-$(VER).tar.gz)
