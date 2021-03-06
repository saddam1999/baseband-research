/*********************************************************************
 *                
 * Copyright (C) 2002,  University of New South Wales
 *                
 * File path:     sigma0/src/arch/alpha/crt0.S
 * Description:   initial runtime for sigma0 
 *                
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 *                
 * $Id: crt0-alpha.S,v 1.1.4.1 2003/09/24 19:13:28 skoglund Exp $
 *                
 ********************************************************************/

#include <l4/alpha/asm.h>
#include <l4/alpha/pal.h>	

#define STACKSIZE 8192
	
BEGIN_PROC(_start)
	bsr	$27, 1f
1:	ldgp	$29, 0($27)
		
	lda	$30, init_stack
	lda	$1, STACKSIZE
	addq	$30, $1, $30

	lda	$27, __L4_Init
	jsr	$26, ($27)

	ldgp	$29, 0($26)
	
	lda	$27, main
	jsr	$26, ($27), main

	lda	$16, 2
	call_pal PAL_gentrap		
END_PROC(_start)

.lcomm init_stack, STACKSIZE

BEGIN_PROC(_start_pager)
	bsr	$27, 1f
1:	ldgp	$29,0($27)
	lda	$27, _Z5pagerv
	jsr	$26, ($27)

	lda	$16, 2
	call_pal PAL_gentrap		
END_PROC(_start_pager)
	

BEGIN_PROC(_start_ping_thread)
	bsr	$27, 1f
1:	ldgp	$29,0($27)
	lda	$27, _Z11ping_threadv
	jsr	$26, ($27)

	lda	$16, 2
	call_pal PAL_gentrap		
END_PROC(_start_ping_thread)

	
BEGIN_PROC(_start_pong_thread)
	bsr	$27, 1f
1:	ldgp	$29,0($27)
	lda	$27, _Z11pong_threadv
	jsr	$26, ($27)

	lda	$16, 2
	call_pal PAL_gentrap		
END_PROC(_start_pong_thread)

		
	

	