	.build_version macos, 15, 0
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0
lCPI0_0:
	.quad	6
	.quad	2305843009213693952
lCPI0_1:
	.quad	39
	.quad	2305843009213693952
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	2
"_bench_dot_product::dot_scalar(::List[::SIMD[::DType(float64), ::Int(1)]],::List[::SIMD[::DType(float64), ::Int(1)]])":
	.cfi_startproc
	stp	x28, x27, [sp, #-48]!
	stp	x20, x19, [sp, #16]
	stp	x29, x30, [sp, #32]
	sub	sp, sp, #2144
	.cfi_def_cfa_offset 2192
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w27, -40
	.cfi_offset w28, -48
	subs	x19, x1, #1
	b.lt	LBB0_6
	mov	x20, #0
	bic	x9, x1, x1, asr #63
	add	x8, x9, #1
	cmp	x9, #1
	csinc	x11, x9, xzr, lo
	movi.2d	v0, #0000000000000000
Lloh0:
	adrp	x9, _static_string_ffe5c571af8dd3fc@PAGE
Lloh1:
	add	x9, x9, _static_string_ffe5c571af8dd3fc@PAGEOFF
Lloh2:
	adrp	x10, lCPI0_0@PAGE
Lloh3:
	ldr	q1, [x10, lCPI0_0@PAGEOFF]
Lloh4:
	adrp	x10, _static_string_a0fcf35b7349c924@PAGE
Lloh5:
	add	x10, x10, _static_string_a0fcf35b7349c924@PAGEOFF
Lloh6:
	adrp	x12, lCPI0_1@PAGE
Lloh7:
	ldr	q2, [x12, lCPI0_1@PAGEOFF]
LBB0_2:
	str	x9, [sp]
	stur	q1, [sp, #8]
	str	x10, [sp, #24]
	stur	q2, [sp, #32]
	cmp	x20, x1
	b.hs	LBB0_9
	str	x9, [sp, #48]
	stur	q1, [sp, #56]
	str	x10, [sp, #72]
	stur	q2, [sp, #80]
	cmp	x20, x4
	b.hs	LBB0_7
	mov	x12, x11
	ldr	d3, [x0, x20, lsl #3]
	ldr	d4, [x3, x20, lsl #3]
	fmadd	d0, d3, d4, d0
	add	x11, x11, #1
	mov	x20, x12
	cmp	x8, x11
	b.ne	LBB0_2
	add	sp, sp, #2144
	ldp	x29, x30, [sp, #32]
	ldp	x20, x19, [sp, #16]
	ldp	x28, x27, [sp], #48
	ret
LBB0_6:
	movi.2d	v0, #0000000000000000
	add	sp, sp, #2144
	ldp	x29, x30, [sp, #32]
	ldp	x20, x19, [sp, #16]
	ldp	x28, x27, [sp], #48
	ret
LBB0_7:
	sub	x19, x4, #1
	add	x0, sp, #48
	add	x1, sp, #96
	mov	x2, #0
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	mov	x0, x20
	mov	x1, x2
	mov	x2, x3
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	add	x0, sp, #72
	mov	x1, x2
	mov	x2, x3
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	mov	x0, x19
	mov	x1, x2
	mov	x2, x3
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	add	x8, x1, #1
	cmp	x8, #2049
	b.ge	LBB0_10
	strb	wzr, [x0, x1]
Lloh8:
	adrp	x3, _static_string_6dc38af2f39195e4@PAGE
Lloh9:
	add	x3, x3, _static_string_6dc38af2f39195e4@PAGEOFF
	mov	w1, #28
	mov	w2, #22
	mov	w4, #129
	bl	"_std::builtin::debug_assert::_debug_assert_msg[LITImmutOrigin,::Origin[::Bool(False), $0]](::UnsafePointer[::Bool(False), $0, ::SIMD[::DType(uint8), ::Int(1)], $1, ::AddressSpace(::Int(0))],::Int,::SourceLocation)"
LBB0_9:
	mov	x0, sp
	add	x1, sp, #96
	mov	x2, #0
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	mov	x0, x20
	mov	x1, x2
	mov	x2, x3
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	add	x0, sp, #24
	mov	x1, x2
	mov	x2, x3
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	mov	x0, x19
	mov	x1, x2
	mov	x2, x3
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	add	x8, x1, #1
	cmp	x8, #2049
	b.lt	LBB0_11
LBB0_10:
	mov	w0, #1
	bl	"_std::io::io::_printf[KGENParamList[::AnyType],::StringSlice[::Bool(False), StaticConstantOrigin, *?],*::AnyType,LITImmutOrigin,::Origin[::Bool(False), $3]](*$0,file:::FileDescriptor),types.values`=[],fmt={ #interp.memref<{[(#interp.memory_handle<16, \"HEAP_BUFFER_BYTES exceeded, increase with: `mojo -D HEAP_BUFFER_BYTES=4096`\\0A\\00\" string>, const_global, [], [])], []}, 0, 0>, 76 }"
	brk	#0x1
LBB0_11:
	strb	wzr, [x0, x1]
Lloh10:
	adrp	x3, _static_string_6dc38af2f39195e4@PAGE
Lloh11:
	add	x3, x3, _static_string_6dc38af2f39195e4@PAGEOFF
	mov	w1, #28
	mov	w2, #15
	mov	w4, #129
	bl	"_std::builtin::debug_assert::_debug_assert_msg[LITImmutOrigin,::Origin[::Bool(False), $0]](::UnsafePointer[::Bool(False), $0, ::SIMD[::DType(uint8), ::Int(1)], $1, ::AddressSpace(::Int(0))],::Int,::SourceLocation)"
	.loh AdrpLdr	Lloh6, Lloh7
	.loh AdrpAdd	Lloh4, Lloh5
	.loh AdrpAdrp	Lloh2, Lloh4
	.loh AdrpLdr	Lloh2, Lloh3
	.loh AdrpAdd	Lloh0, Lloh1
	.loh AdrpAdd	Lloh8, Lloh9
	.loh AdrpAdd	Lloh10, Lloh11
	.cfi_endproc

	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0
lCPI1_0:
	.quad	6
	.quad	2305843009213693952
lCPI1_1:
	.quad	39
	.quad	2305843009213693952
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	2
"_bench_dot_product::dot_simd[::Int](::List[::SIMD[::DType(float64), ::Int(1)]],::List[::SIMD[::DType(float64), ::Int(1)]]),width=2":
	.cfi_startproc
	stp	x28, x27, [sp, #-48]!
	stp	x20, x19, [sp, #16]
	stp	x29, x30, [sp, #32]
	sub	sp, sp, #2144
	.cfi_def_cfa_offset 2192
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w27, -40
	.cfi_offset w28, -48
	cmp	x1, #2
	b.ge	LBB1_2
	mov	x13, #0
	movi.2d	v0, #0000000000000000
	b	LBB1_4
LBB1_2:
	mov	x13, #0
	movi.2d	v0, #0000000000000000
	mov	x8, x0
	mov	x9, x3
LBB1_3:
	ldr	q1, [x8], #16
	ldr	q2, [x9], #16
	fmla.2d	v0, v1, v2
	add	x10, x13, #4
	add	x13, x13, #2
	cmp	x10, x1
	b.le	LBB1_3
LBB1_4:
	movi.2d	v1, #0000000000000000
	subs	x8, x1, x13
	b.le	LBB1_9
	csel	x20, x1, x13, hi
	cmp	x4, x13
	csel	x9, x4, x13, hi
	lsl	x11, x13, #3
	add	x10, x3, x11
	add	x11, x0, x11
	sub	x12, x9, x13
	sub	x13, x20, x13
Lloh12:
	adrp	x14, _static_string_ffe5c571af8dd3fc@PAGE
Lloh13:
	add	x14, x14, _static_string_ffe5c571af8dd3fc@PAGEOFF
Lloh14:
	adrp	x15, lCPI1_0@PAGE
Lloh15:
	ldr	q2, [x15, lCPI1_0@PAGEOFF]
Lloh16:
	adrp	x15, lCPI1_1@PAGE
Lloh17:
	ldr	q3, [x15, lCPI1_1@PAGEOFF]
Lloh18:
	adrp	x15, _static_string_a0fcf35b7349c924@PAGE
Lloh19:
	add	x15, x15, _static_string_a0fcf35b7349c924@PAGEOFF
LBB1_6:
	str	x14, [sp]
	stur	q2, [sp, #8]
	str	x15, [sp, #24]
	stur	q3, [sp, #32]
	cbz	x13, LBB1_10
	str	x14, [sp, #48]
	stur	q2, [sp, #56]
	str	x15, [sp, #72]
	stur	q3, [sp, #80]
	cbz	x12, LBB1_12
	ldr	d4, [x11], #8
	ldr	d5, [x10], #8
	fmadd	d1, d4, d5, d1
	sub	x12, x12, #1
	sub	x13, x13, #1
	sub	x8, x8, #1
	cbnz	x8, LBB1_6
LBB1_9:
	faddp.2d	d0, v0
	fadd	d0, d0, d1
	add	sp, sp, #2144
	ldp	x29, x30, [sp, #32]
	ldp	x20, x19, [sp, #16]
	ldp	x28, x27, [sp], #48
	ret
LBB1_10:
	sub	x19, x1, #1
	mov	x0, sp
	add	x1, sp, #96
	mov	x2, #0
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	mov	x0, x20
	mov	x1, x2
	mov	x2, x3
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	add	x0, sp, #24
	mov	x1, x2
	mov	x2, x3
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	mov	x0, x19
	mov	x1, x2
	mov	x2, x3
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	add	x8, x1, #1
	cmp	x8, #2049
	b.ge	LBB1_13
	strb	wzr, [x0, x1]
Lloh20:
	adrp	x3, _static_string_6dc38af2f39195e4@PAGE
Lloh21:
	add	x3, x3, _static_string_6dc38af2f39195e4@PAGEOFF
	mov	w1, #44
	mov	w2, #18
	mov	w4, #129
	bl	"_std::builtin::debug_assert::_debug_assert_msg[LITImmutOrigin,::Origin[::Bool(False), $0]](::UnsafePointer[::Bool(False), $0, ::SIMD[::DType(uint8), ::Int(1)], $1, ::AddressSpace(::Int(0))],::Int,::SourceLocation)"
LBB1_12:
	sub	x19, x4, #1
	mov	x20, x9
	add	x0, sp, #48
	add	x1, sp, #96
	mov	x2, #0
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	mov	x0, x20
	mov	x1, x2
	mov	x2, x3
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	add	x0, sp, #72
	mov	x1, x2
	mov	x2, x3
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	mov	x0, x19
	mov	x1, x2
	mov	x2, x3
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	add	x8, x1, #1
	cmp	x8, #2049
	b.lt	LBB1_14
LBB1_13:
	mov	w0, #1
	bl	"_std::io::io::_printf[KGENParamList[::AnyType],::StringSlice[::Bool(False), StaticConstantOrigin, *?],*::AnyType,LITImmutOrigin,::Origin[::Bool(False), $3]](*$0,file:::FileDescriptor),types.values`=[],fmt={ #interp.memref<{[(#interp.memory_handle<16, \"HEAP_BUFFER_BYTES exceeded, increase with: `mojo -D HEAP_BUFFER_BYTES=4096`\\0A\\00\" string>, const_global, [], [])], []}, 0, 0>, 76 }"
	brk	#0x1
LBB1_14:
	strb	wzr, [x0, x1]
Lloh22:
	adrp	x3, _static_string_6dc38af2f39195e4@PAGE
Lloh23:
	add	x3, x3, _static_string_6dc38af2f39195e4@PAGEOFF
	mov	w1, #44
	mov	w2, #25
	mov	w4, #129
	bl	"_std::builtin::debug_assert::_debug_assert_msg[LITImmutOrigin,::Origin[::Bool(False), $0]](::UnsafePointer[::Bool(False), $0, ::SIMD[::DType(uint8), ::Int(1)], $1, ::AddressSpace(::Int(0))],::Int,::SourceLocation)"
	.loh AdrpAdd	Lloh18, Lloh19
	.loh AdrpAdrp	Lloh16, Lloh18
	.loh AdrpLdr	Lloh16, Lloh17
	.loh AdrpAdrp	Lloh14, Lloh16
	.loh AdrpLdr	Lloh14, Lloh15
	.loh AdrpAdd	Lloh12, Lloh13
	.loh AdrpAdd	Lloh20, Lloh21
	.loh AdrpAdd	Lloh22, Lloh23
	.cfi_endproc

	.p2align	2
_main_closure_0:
	.cfi_startproc
	b	_KGEN_CompilerRT_AsyncRT_GetOrCreateRuntime
	.cfi_endproc

	.p2align	2
_main_closure_1:
	.cfi_startproc
	b	_KGEN_CompilerRT_AsyncRT_ReleaseRuntime
	.cfi_endproc

	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0
lCPI4_0:
	.quad	19
	.quad	2305843009213693952
lCPI4_1:
	.quad	28
	.quad	2305843009213693952
lCPI4_2:
	.quad	27
	.quad	2305843009213693952
lCPI4_3:
	.quad	26
	.quad	2305843009213693952
lCPI4_4:
	.quad	25
	.quad	2305843009213693952
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_main
	.p2align	2
_main:
	.cfi_startproc
	stp	d9, d8, [sp, #-112]!
	stp	x28, x27, [sp, #16]
	stp	x26, x25, [sp, #32]
	stp	x24, x23, [sp, #48]
	stp	x22, x21, [sp, #64]
	stp	x20, x19, [sp, #80]
	stp	x29, x30, [sp, #96]
	sub	sp, sp, #496
	.cfi_def_cfa_offset 608
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	.cfi_offset w27, -88
	.cfi_offset w28, -96
	.cfi_offset b8, -104
	.cfi_offset b9, -112
	mov	x19, x1
	mov	x20, x0
	bl	_KGEN_CompilerRT_AsyncRT_GetCurrentRuntime
	cbnz	x0, LBB4_2
Lloh24:
	adrp	x0, _static_string_a61c3395ab9379d9@PAGE
Lloh25:
	add	x0, x0, _static_string_a61c3395ab9379d9@PAGEOFF
Lloh26:
	adrp	x2, _main_closure_0@GOTPAGE
Lloh27:
	ldr	x2, [x2, _main_closure_0@GOTPAGEOFF]
Lloh28:
	adrp	x3, _main_closure_1@GOTPAGE
Lloh29:
	ldr	x3, [x3, _main_closure_1@GOTPAGEOFF]
	mov	w1, #7
	bl	_KGEN_CompilerRT_GetOrCreateGlobal
LBB4_2:
	mov	x0, x20
	mov	x1, x19
	bl	_KGEN_CompilerRT_SetArgV
	bl	_KGEN_CompilerRT_PrintStackTraceOnFault
	bl	"_std::random::_rng::_get_global_random_state()"
	mov	x19, #0
	mov	x22, #0
	mov	x21, #0
	mov	x23, #0
	mov	w8, #42
	str	x8, [x0]
	movi.2d	v0, #0000000000000000
	stp	q0, q0, [x0, #16]
	mov	w8, #4
	str	x8, [x0, #48]
	mov	x27, #-38528
	movk	x27, #65383, lsl #16
	mov	w20, #8
	mov	w24, #8
	b	LBB4_4
LBB4_3:
	add	x23, x23, #1
	orr	x8, x26, x28, lsl #32
	lsr	x8, x8, #11
	ucvtf	d0, x8, #53
	str	d0, [x20, x22, lsl #3]
	add	x22, x22, #1
	adds	x27, x27, #1
	b.hs	LBB4_8
LBB4_4:
	bl	"_std::random::_rng::_get_global_random_state()"
	mov	x25, x0
	ldr	d0, [x0]
	ldp	q1, q2, [x0, #16]
	ldr	x8, [x0, #48]
	ldrb	w7, [x0, #15]
	ldrb	w6, [x0, #14]
	ldrb	w5, [x0, #13]
	ldrb	w4, [x0, #12]
	ldrb	w3, [x0, #11]
	ldrb	w2, [x0, #10]
	ldrb	w1, [x0, #9]
	ldrb	w0, [x0, #8]
	str	x8, [sp]
	add	x8, sp, #272
	bl	"_std::random::_rng::_PhiloxWrapper::next_uint32(::_PhiloxWrapper&)"
	ldp	q1, q2, [sp, #304]
	ldr	d0, [sp, #288]
	ldr	x8, [sp, #336]
	ldr	w28, [sp, #272]
	ldrb	w7, [sp, #303]
	ldrb	w6, [sp, #302]
	ldrb	w5, [sp, #301]
	ldrb	w4, [sp, #300]
	ldrb	w3, [sp, #299]
	ldrb	w2, [sp, #298]
	ldrb	w1, [sp, #297]
	ldrb	w0, [sp, #296]
	str	x8, [sp]
	add	x8, sp, #192
	bl	"_std::random::_rng::_PhiloxWrapper::next_uint32(::_PhiloxWrapper&)"
	ldr	w26, [sp, #192]
	ldr	d0, [sp, #208]
	ldr	x8, [sp, #216]
	ldp	q1, q2, [sp, #224]
	ldr	x9, [sp, #256]
	str	x9, [x25, #48]
	stp	q1, q2, [x25, #16]
	str	x8, [x25, #8]
	str	d0, [x25]
	cmp	x23, x21
	b.lt	LBB4_6
	cmp	x21, #0
	cset	w8, eq
	orr	x3, x8, x21, lsl #1
	mov	x0, x24
	mov	x1, x23
	mov	x2, x21
	bl	"_std::collections::list::List::_realloc(::List[$0]&,::Int),T=[typevalue<#kgen.instref<\"std::builtin::simd::SIMD,dtype=f64,size=1\">>, scalar<f64>]"
	mov	x24, x0
	mov	x23, x1
	mov	x21, x2
LBB4_6:
	orr	x8, x26, x28, lsl #32
	lsr	x8, x8, #11
	ucvtf	d0, x8, #53
	str	d0, [x24, x23, lsl #3]
	bl	"_std::random::_rng::_get_global_random_state()"
	mov	x25, x0
	ldr	d0, [x0]
	ldp	q1, q2, [x0, #16]
	ldr	x8, [x0, #48]
	ldrb	w7, [x0, #15]
	ldrb	w6, [x0, #14]
	ldrb	w5, [x0, #13]
	ldrb	w4, [x0, #12]
	ldrb	w3, [x0, #11]
	ldrb	w2, [x0, #10]
	ldrb	w1, [x0, #9]
	ldrb	w0, [x0, #8]
	str	x8, [sp]
	add	x8, sp, #112
	bl	"_std::random::_rng::_PhiloxWrapper::next_uint32(::_PhiloxWrapper&)"
	ldp	q1, q2, [sp, #144]
	ldr	d0, [sp, #128]
	ldr	x8, [sp, #176]
	ldr	w28, [sp, #112]
	ldrb	w7, [sp, #143]
	ldrb	w6, [sp, #142]
	ldrb	w5, [sp, #141]
	ldrb	w4, [sp, #140]
	ldrb	w3, [sp, #139]
	ldrb	w2, [sp, #138]
	ldrb	w1, [sp, #137]
	ldrb	w0, [sp, #136]
	str	x8, [sp]
	add	x8, sp, #32
	bl	"_std::random::_rng::_PhiloxWrapper::next_uint32(::_PhiloxWrapper&)"
	ldr	w26, [sp, #32]
	ldr	d0, [sp, #48]
	ldr	x8, [sp, #56]
	ldp	q1, q2, [sp, #64]
	ldr	x9, [sp, #96]
	str	x9, [x25, #48]
	stp	q1, q2, [x25, #16]
	str	x8, [x25, #8]
	str	d0, [x25]
	cmp	x22, x19
	b.lt	LBB4_3
	cmp	x19, #0
	cset	w8, eq
	orr	x3, x8, x19, lsl #1
	mov	x0, x20
	mov	x1, x22
	mov	x2, x19
	bl	"_std::collections::list::List::_realloc(::List[$0]&,::Int),T=[typevalue<#kgen.instref<\"std::builtin::simd::SIMD,dtype=f64,size=1\">>, scalar<f64>]"
	mov	x20, x0
	mov	x22, x1
	mov	x19, x2
	b	LBB4_3
LBB4_8:
Lloh30:
	adrp	x8, _static_string_302229805fc33311@PAGE
Lloh31:
	add	x8, x8, _static_string_302229805fc33311@PAGEOFF
	str	x8, [sp, #352]
Lloh32:
	adrp	x8, lCPI4_0@PAGE
Lloh33:
	ldr	q0, [x8, lCPI4_0@PAGEOFF]
	add	x28, sp, #352
	stur	q0, [x28, #8]
Lloh34:
	adrp	x2, _static_string_a8d4ace0dc8d360e@PAGE
Lloh35:
	add	x2, x2, _static_string_a8d4ace0dc8d360e@PAGEOFF
Lloh36:
	adrp	x4, _static_string_bbe01a6a523daf15@PAGE
Lloh37:
	add	x4, x4, _static_string_bbe01a6a523daf15@PAGEOFF
	add	x0, sp, #352
	mov	w1, #38528
	movk	w1, #152, lsl #16
	mov	w3, #1
	mov	w5, #1
	mov	w6, #0
	mov	w7, #1
	bl	"_std::io::io::print[KGENParamList[::Writable],*::Writable,LITImmutOrigin,::Origin[::Bool(False), $2]](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts.values`=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index]]"
	ldrb	w8, [sp, #375]
	tbz	w8, #6, LBB4_11
	ldr	x8, [sp, #352]
	sub	x0, x8, #8
	mov	x8, #-1
	ldaddal	x8, x8, [x0]
	cmp	x8, #1
	b.ne	LBB4_11
	dmb	ishld
	bl	_KGEN_CompilerRT_AlignedFree
LBB4_11:
Lloh38:
	adrp	x8, _static_string_91654eea92a30b37@PAGE
Lloh39:
	add	x8, x8, _static_string_91654eea92a30b37@PAGEOFF
	str	x8, [sp, #376]
Lloh40:
	adrp	x8, lCPI4_1@PAGE
Lloh41:
	ldr	q0, [x8, lCPI4_1@PAGEOFF]
	str	q0, [sp, #16]
	stur	q0, [x28, #32]
Lloh42:
	adrp	x2, _static_string_a8d4ace0dc8d360e@PAGE
Lloh43:
	add	x2, x2, _static_string_a8d4ace0dc8d360e@PAGEOFF
Lloh44:
	adrp	x4, _static_string_bbe01a6a523daf15@PAGE
Lloh45:
	add	x4, x4, _static_string_bbe01a6a523daf15@PAGEOFF
	add	x0, sp, #376
	mov	w1, #2
	mov	w3, #1
	mov	w5, #1
	mov	w6, #0
	mov	w7, #1
	bl	"_std::io::io::print[KGENParamList[::Writable],*::Writable,LITImmutOrigin,::Origin[::Bool(False), $2]](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts.values`=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index]]"
	ldrb	w8, [sp, #399]
	tbz	w8, #6, LBB4_14
	ldr	x8, [sp, #376]
	sub	x0, x8, #8
	mov	x8, #-1
	ldaddal	x8, x8, [x0]
	cmp	x8, #1
	b.ne	LBB4_14
	dmb	ishld
	bl	_KGEN_CompilerRT_AlignedFree
LBB4_14:
	mov	x25, #-3
LBB4_15:
	mov	x0, x24
	mov	x1, x23
	mov	x2, x21
	mov	x3, x20
	mov	x4, x22
	mov	x5, x19
	bl	"_bench_dot_product::dot_scalar(::List[::SIMD[::DType(float64), ::Int(1)]],::List[::SIMD[::DType(float64), ::Int(1)]])"
	adds	x25, x25, #1
	b.lo	LBB4_15
	mov	x26, #0
	mov	x27, #0
LBB4_17:
	mov	w0, #6
	bl	_clock_gettime_nsec_np
	mov	x25, x0
	mov	x0, x24
	mov	x1, x23
	mov	x2, x21
	mov	x3, x20
	mov	x4, x22
	mov	x5, x19
	bl	"_bench_dot_product::dot_scalar(::List[::SIMD[::DType(float64), ::Int(1)]],::List[::SIMD[::DType(float64), ::Int(1)]])"
	mov.16b	v8, v0
	mov	w0, #6
	bl	_clock_gettime_nsec_np
	sub	x8, x0, x25
	cmp	x8, x27
	csel	x1, x8, x27, lo
	cmp	x26, #0
	csel	x27, x8, x1, eq
	add	x26, x26, #1
	cmp	x26, #5
	b.ne	LBB4_17
Lloh46:
	adrp	x8, _static_string_9e3f690336f5b872@PAGE
Lloh47:
	add	x8, x8, _static_string_9e3f690336f5b872@PAGEOFF
	str	x8, [sp, #400]
	ldr	q0, [sp, #16]
	stur	q0, [x28, #56]
Lloh48:
	adrp	x2, _static_string_a8d4ace0dc8d360e@PAGE
Lloh49:
	add	x2, x2, _static_string_a8d4ace0dc8d360e@PAGEOFF
Lloh50:
	adrp	x4, _static_string_bbe01a6a523daf15@PAGE
Lloh51:
	add	x4, x4, _static_string_bbe01a6a523daf15@PAGEOFF
	add	x0, sp, #400
	mov	w3, #1
	mov	w5, #1
	mov	w6, #0
	mov	w7, #1
	bl	"_std::io::io::print[KGENParamList[::Writable],*::Writable,LITImmutOrigin,::Origin[::Bool(False), $2]](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts.values`=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::simd::SIMD,dtype=uindex,size=1\">>, scalar<uindex>]]"
	ldrb	w8, [sp, #423]
	tbz	w8, #6, LBB4_21
	ldr	x8, [sp, #400]
	sub	x0, x8, #8
	mov	x8, #-1
	ldaddal	x8, x8, [x0]
	cmp	x8, #1
	b.ne	LBB4_21
	dmb	ishld
	bl	_KGEN_CompilerRT_AlignedFree
LBB4_21:
Lloh52:
	adrp	x8, _static_string_7a6237f4a9cb54dc@PAGE
Lloh53:
	add	x8, x8, _static_string_7a6237f4a9cb54dc@PAGEOFF
	str	x8, [sp, #424]
Lloh54:
	adrp	x8, lCPI4_2@PAGE
Lloh55:
	ldr	q0, [x8, lCPI4_2@PAGEOFF]
	stur	q0, [x28, #80]
Lloh56:
	adrp	x1, _static_string_a8d4ace0dc8d360e@PAGE
Lloh57:
	add	x1, x1, _static_string_a8d4ace0dc8d360e@PAGEOFF
Lloh58:
	adrp	x3, _static_string_bbe01a6a523daf15@PAGE
Lloh59:
	add	x3, x3, _static_string_bbe01a6a523daf15@PAGEOFF
	add	x0, sp, #424
	mov.16b	v0, v8
	mov	w2, #1
	mov	w4, #1
	mov	w5, #0
	mov	w6, #1
	bl	"_std::io::io::print[KGENParamList[::Writable],*::Writable,LITImmutOrigin,::Origin[::Bool(False), $2]](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts.values`=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::simd::SIMD,dtype=f64,size=1\">>, scalar<f64>]]"
	ldrb	w8, [sp, #447]
	tbz	w8, #6, LBB4_24
	ldr	x8, [sp, #424]
	sub	x0, x8, #8
	mov	x8, #-1
	ldaddal	x8, x8, [x0]
	cmp	x8, #1
	b.ne	LBB4_24
	dmb	ishld
	bl	_KGEN_CompilerRT_AlignedFree
LBB4_24:
	mov	x25, #-3
LBB4_25:
	mov	x0, x24
	mov	x1, x23
	mov	x2, x21
	mov	x3, x20
	mov	x4, x22
	mov	x5, x19
	bl	"_bench_dot_product::dot_simd[::Int](::List[::SIMD[::DType(float64), ::Int(1)]],::List[::SIMD[::DType(float64), ::Int(1)]]),width=2"
	adds	x25, x25, #1
	b.lo	LBB4_25
	mov	x26, #0
	mov	x27, #0
LBB4_27:
	mov	w0, #6
	bl	_clock_gettime_nsec_np
	mov	x25, x0
	mov	x0, x24
	mov	x1, x23
	mov	x2, x21
	mov	x3, x20
	mov	x4, x22
	mov	x5, x19
	bl	"_bench_dot_product::dot_simd[::Int](::List[::SIMD[::DType(float64), ::Int(1)]],::List[::SIMD[::DType(float64), ::Int(1)]]),width=2"
	mov.16b	v8, v0
	mov	w0, #6
	bl	_clock_gettime_nsec_np
	sub	x8, x0, x25
	cmp	x8, x27
	csel	x25, x8, x27, lo
	cmp	x26, #0
	csel	x27, x8, x25, eq
	add	x26, x26, #1
	cmp	x26, #5
	b.ne	LBB4_27
	cmp	x21, #1
	b.lt	LBB4_30
	mov	x0, x24
	bl	_KGEN_CompilerRT_AlignedFree
LBB4_30:
	cmp	x19, #1
	b.lt	LBB4_32
	mov	x0, x20
	bl	_KGEN_CompilerRT_AlignedFree
LBB4_32:
Lloh60:
	adrp	x8, _static_string_1618a6be9bfb1861@PAGE
Lloh61:
	add	x8, x8, _static_string_1618a6be9bfb1861@PAGEOFF
	str	x8, [sp, #448]
Lloh62:
	adrp	x8, lCPI4_3@PAGE
Lloh63:
	ldr	q0, [x8, lCPI4_3@PAGEOFF]
	stur	q0, [x28, #104]
Lloh64:
	adrp	x2, _static_string_a8d4ace0dc8d360e@PAGE
Lloh65:
	add	x2, x2, _static_string_a8d4ace0dc8d360e@PAGEOFF
Lloh66:
	adrp	x4, _static_string_bbe01a6a523daf15@PAGE
Lloh67:
	add	x4, x4, _static_string_bbe01a6a523daf15@PAGEOFF
	add	x0, sp, #448
	mov	x1, x25
	mov	w3, #1
	mov	w5, #1
	mov	w6, #0
	mov	w7, #1
	bl	"_std::io::io::print[KGENParamList[::Writable],*::Writable,LITImmutOrigin,::Origin[::Bool(False), $2]](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts.values`=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::simd::SIMD,dtype=uindex,size=1\">>, scalar<uindex>]]"
	ldrb	w8, [sp, #471]
	tbz	w8, #6, LBB4_35
	ldr	x8, [sp, #448]
	sub	x0, x8, #8
	mov	x8, #-1
	ldaddal	x8, x8, [x0]
	cmp	x8, #1
	b.ne	LBB4_35
	dmb	ishld
	bl	_KGEN_CompilerRT_AlignedFree
LBB4_35:
Lloh68:
	adrp	x8, _static_string_51c95ecb49d4d75a@PAGE
Lloh69:
	add	x8, x8, _static_string_51c95ecb49d4d75a@PAGEOFF
	str	x8, [sp, #472]
Lloh70:
	adrp	x8, lCPI4_4@PAGE
Lloh71:
	ldr	q0, [x8, lCPI4_4@PAGEOFF]
	stur	q0, [x28, #128]
Lloh72:
	adrp	x1, _static_string_a8d4ace0dc8d360e@PAGE
Lloh73:
	add	x1, x1, _static_string_a8d4ace0dc8d360e@PAGEOFF
Lloh74:
	adrp	x3, _static_string_bbe01a6a523daf15@PAGE
Lloh75:
	add	x3, x3, _static_string_bbe01a6a523daf15@PAGEOFF
	add	x0, sp, #472
	mov.16b	v0, v8
	mov	w2, #1
	mov	w4, #1
	mov	w5, #0
	mov	w6, #1
	bl	"_std::io::io::print[KGENParamList[::Writable],*::Writable,LITImmutOrigin,::Origin[::Bool(False), $2]](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts.values`=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::simd::SIMD,dtype=f64,size=1\">>, scalar<f64>]]"
	ldrb	w8, [sp, #495]
	tbz	w8, #6, LBB4_38
	ldr	x8, [sp, #472]
	sub	x0, x8, #8
	mov	x8, #-1
	ldaddal	x8, x8, [x0]
	cmp	x8, #1
	b.ne	LBB4_38
	dmb	ishld
	bl	_KGEN_CompilerRT_AlignedFree
LBB4_38:
	bl	_KGEN_CompilerRT_DestroyGlobals
	mov	w0, #0
	add	sp, sp, #496
	ldp	x29, x30, [sp, #96]
	ldp	x20, x19, [sp, #80]
	ldp	x22, x21, [sp, #64]
	ldp	x24, x23, [sp, #48]
	ldp	x26, x25, [sp, #32]
	ldp	x28, x27, [sp, #16]
	ldp	d9, d8, [sp], #112
	ret
	.loh AdrpLdrGot	Lloh28, Lloh29
	.loh AdrpLdrGot	Lloh26, Lloh27
	.loh AdrpAdd	Lloh24, Lloh25
	.loh AdrpAdd	Lloh36, Lloh37
	.loh AdrpAdd	Lloh34, Lloh35
	.loh AdrpLdr	Lloh32, Lloh33
	.loh AdrpAdd	Lloh30, Lloh31
	.loh AdrpAdd	Lloh44, Lloh45
	.loh AdrpAdd	Lloh42, Lloh43
	.loh AdrpLdr	Lloh40, Lloh41
	.loh AdrpAdd	Lloh38, Lloh39
	.loh AdrpAdd	Lloh50, Lloh51
	.loh AdrpAdd	Lloh48, Lloh49
	.loh AdrpAdd	Lloh46, Lloh47
	.loh AdrpAdd	Lloh58, Lloh59
	.loh AdrpAdd	Lloh56, Lloh57
	.loh AdrpLdr	Lloh54, Lloh55
	.loh AdrpAdd	Lloh52, Lloh53
	.loh AdrpAdd	Lloh66, Lloh67
	.loh AdrpAdd	Lloh64, Lloh65
	.loh AdrpLdr	Lloh62, Lloh63
	.loh AdrpAdd	Lloh60, Lloh61
	.loh AdrpAdd	Lloh74, Lloh75
	.loh AdrpAdd	Lloh72, Lloh73
	.loh AdrpLdr	Lloh70, Lloh71
	.loh AdrpAdd	Lloh68, Lloh69
	.cfi_endproc

	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0
lCPI5_0:
	.quad	6
	.quad	2305843009213693952
lCPI5_1:
	.quad	39
	.quad	2305843009213693952
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	2
"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=f64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]":
	.cfi_startproc
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	sub	sp, sp, #2368
	.cfi_def_cfa_offset 2464
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	.cfi_offset w27, -88
	.cfi_offset w28, -96
	mov	x19, x0
	fmov	x8, d0
	mov	w10, #2047
	ands	x9, x10, x8, lsr #52
	sub	x21, x9, #1075
	tst	x10, x8, lsr #52
	mov	x9, #-1074
	csel	x22, x9, x21, eq
	ands	x9, x8, #0xfffffffffffff
	cset	w11, ne
	ands	x10, x10, x8, lsr #52
	lsl	x12, x9, #1
	orr	x13, x12, #0x20000000000000
	csel	x20, x12, x13, eq
	csinc	w24, w11, wzr, ne
	sub	x11, x10, #1079
	cmn	x11, #2
	cset	w23, lo
	mov	x11, #-9007199254740992
	cmp	x11, x8, lsl #1
	b.ne	LBB5_5
	ldr	x2, [x19, #4096]
	tbnz	x8, #63, LBB5_11
	add	x8, x2, #3
	cmp	x8, #1, lsl #12
	b.le	LBB5_4
	ldr	x8, [x19, #4104]
	ldr	x0, [x8]
	mov	x1, x19
	bl	_write
	mov	x2, #0
	str	xzr, [x19, #4096]
LBB5_4:
	add	x8, x19, x2
	mov	w9, #28265
	strh	w9, [x8]
	mov	w9, #102
	b	LBB5_21
LBB5_5:
	fcmp	d0, d0
	b.vs	LBB5_115
	orr	x9, x10, x9
	cbz	x9, LBB5_14
	tbnz	x8, #63, LBB5_24
	mov	x8, #-37711
	movk	x8, #65509, lsl #16
	tbz	w24, #0, LBB5_27
LBB5_9:
	mov	w9, #53509
	movk	w9, #4, lsl #16
	mul	x9, x22, x9
	mov	w10, #9886
	movk	w10, #53, lsl #16
	asr	x24, x9, #20
	madd	x8, x24, x8, x10
	add	x22, x22, x8, asr #19
	orr	x8, x20, #0x1
	mov	w9, #294
	lsl	x8, x8, x22
	mov	w10, #63
	sub	x23, x9, x24
	lsr	x9, x8, #32
	add	x25, x24, #1
	sub	x10, x10, x22
Lloh76:
	adrp	x11, _global_constant@PAGE
Lloh77:
	add	x11, x11, _global_constant@PAGEOFF
	add	x11, x11, x23, lsl #4
	ldp	x12, x11, [x11]
	lsr	x21, x11, x10
	lsr	x10, x11, #32
	umull	x13, w8, w10
	umull	x14, w11, w9
	umull	x11, w11, w8
	mov	w15, w14
	add	x15, x15, w13, uxtw
	add	x15, x15, x11, lsr #32
	lsr	x16, x15, #32
	lsr	x13, x13, #32
	umaddl	x9, w9, w10, x13
	add	x9, x9, x14, lsr #32
	bfi	x11, x15, #32, #32
	umulh	x8, x8, x12
	cmn	x8, x11
	adc	x8, x9, x16
	lsr	x9, x8, #32
	mov	w10, #14155
	movk	w10, #16777, lsl #16
	umull	x11, w8, w10
	mov	w12, #61342
	movk	w12, #50855, lsl #16
	umull	x13, w9, w12
	umull	x12, w8, w12
	mov	w14, w13
	add	x12, x14, x12, lsr #32
	add	x12, x12, w11, uxtw
	lsr	x13, x13, #32
	umaddl	x9, w9, w10, x13
	add	x9, x9, x11, lsr #32
	add	x9, x9, x12, lsr #32
	lsr	x26, x9, #8
	mov	x9, #-1000
	madd	x27, x26, x9, x8
	cmp	x27, x21
	b.hs	LBB5_29
LBB5_10:
	mov	x8, #3617
	movk	x8, #8937, lsl #16
	movk	x8, #1867, lsl #32
	movk	x8, #103, lsl #48
	mul	x8, x26, x8
	lsr	x8, x8, #8
	add	w9, w26, w26, lsl #5
	orr	x8, x8, x9, lsl #56
	mov	x9, #50274
	movk	x9, #62237, lsl #16
	movk	x9, #42, lsl #32
	cmp	x8, x9
	csel	x8, x8, x26, lo
	mov	x9, #32401
	movk	x9, #15099, lsl #16
	movk	x9, #52848, lsl #32
	movk	x9, #648, lsl #48
	mul	x9, x8, x9
	extr	x9, x8, x9, #4
	mov	w10, #2
	csel	x11, x10, xzr, lo
	mov	x12, #4300
	movk	x12, #47815, lsl #16
	movk	x12, #36280, lsl #32
	movk	x12, #6, lsl #48
	cmp	x9, x12
	csel	x8, x9, x8, lo
	cinc	x9, x11, lo
	mov	x11, #23593
	movk	x11, #49807, lsl #16
	movk	x11, #10485, lsl #32
	movk	x11, #36700, lsl #48
	mul	x11, x8, x11
	extr	x11, x8, x11, #2
	mov	x12, #36701
	movk	x12, #62914, lsl #16
	movk	x12, #23592, lsl #32
	movk	x12, #655, lsl #48
	cmp	x11, x12
	csel	x8, x11, x8, lo
	mov	x11, #-3689348814741910324
	movk	x11, #52429
	mul	x11, x8, x11
	extr	x11, x8, x11, #1
	csel	x10, x10, xzr, lo
	mov	x12, #-7378697629483820647
	movk	x12, #6553, lsl #48
	cmp	x11, x12
	csel	x21, x11, x8, ls
	add	x8, x25, x9, lsl #2
	add	x8, x8, x10
	b	LBB5_35
LBB5_11:
	add	x8, x2, #4
	cmp	x8, #1, lsl #12
	b.le	LBB5_13
	ldr	x8, [x19, #4104]
	ldr	x0, [x8]
	mov	x1, x19
	bl	_write
	mov	x2, #0
	str	xzr, [x19, #4096]
LBB5_13:
	mov	w8, #26925
	movk	w8, #26222, lsl #16
	str	w8, [x19, x2]
	ldr	x8, [x19, #4096]
	add	x8, x8, #4
	b	LBB5_22
LBB5_14:
	ldr	x2, [x19, #4096]
	tbz	x8, #63, LBB5_18
	add	x8, x2, #1
	cmp	x8, #1, lsl #12
	b.le	LBB5_17
	ldr	x8, [x19, #4104]
	ldr	x0, [x8]
	mov	x1, x19
	bl	_write
	mov	x2, #0
	str	xzr, [x19, #4096]
LBB5_17:
	mov	w8, #45
	strb	w8, [x19, x2]
	ldr	x8, [x19, #4096]
	add	x2, x8, #1
	str	x2, [x19, #4096]
LBB5_18:
	add	x8, x2, #3
	cmp	x8, #1, lsl #12
	b.le	LBB5_20
	ldr	x8, [x19, #4104]
	ldr	x0, [x8]
	mov	x1, x19
	bl	_write
	mov	x2, #0
	str	xzr, [x19, #4096]
LBB5_20:
	add	x8, x19, x2
	mov	w9, #11824
	strh	w9, [x8]
	mov	w9, #48
LBB5_21:
	strb	w9, [x8, #2]
	ldr	x8, [x19, #4096]
	add	x8, x8, #3
LBB5_22:
	str	x8, [x19, #4096]
LBB5_23:
	add	sp, sp, #2368
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
LBB5_24:
	ldr	x2, [x19, #4096]
	add	x8, x2, #1
	cmp	x8, #1, lsl #12
	b.le	LBB5_26
	ldr	x8, [x19, #4104]
	ldr	x0, [x8]
	mov	x1, x19
	bl	_write
	mov	x2, #0
	str	xzr, [x19, #4096]
LBB5_26:
	mov	w8, #45
	strb	w8, [x19, x2]
	ldr	x8, [x19, #4096]
	add	x8, x8, #1
	str	x8, [x19, #4096]
	mov	x8, #-37711
	movk	x8, #65509, lsl #16
	tbnz	w24, #0, LBB5_9
LBB5_27:
	mov	w9, #41481
	movk	w9, #9, lsl #16
	mov	x10, #-65055
	movk	x10, #65532, lsl #16
	madd	x9, x21, x9, x10
	asr	x24, x9, #21
	mov	w9, #292
	mul	x8, x24, x8
	add	x21, x21, x8, asr #19
	sub	x20, x9, x24
	mov	x0, x20
	mov	x1, x21
	mov	w2, #1
	bl	"_std::builtin::_format_float::_compute_endpoint[::DType,::Int,::Int,::Int](::Int,::Int,::Bool),CarrierDType=ui64,sig_bits=52,total_bits=64,cache_bits=128"
	mov	x22, x0
	mov	x0, x20
	mov	x1, x21
	mov	w2, #0
	bl	"_std::builtin::_format_float::_compute_endpoint[::DType,::Int,::Int,::Int](::Int,::Int,::Bool),CarrierDType=ui64,sig_bits=52,total_bits=64,cache_bits=128"
	lsr	x8, x0, #32
	mov	w9, #39322
	movk	w9, #39321, lsl #16
	umull	x10, w8, w9
	umull	x9, w0, w9
	mov	w11, w10
	add	x9, x11, x9, lsr #32
	mov	w11, #39321
	movk	w11, #6553, lsl #16
	umull	x12, w0, w11
	add	x9, x9, w12, uxtw
	lsr	x10, x10, #32
	umaddl	x8, w8, w11, x10
	add	x8, x8, x12, lsr #32
	add	x8, x8, x9, lsr #32
	add	x9, x8, x8, lsl #2
	lsl	x10, x9, #1
	add	x9, x22, x23
	cmp	x10, x9
	b.hs	LBB5_34
	mov	w8, #10
	sub	x8, x8, x21
Lloh78:
	adrp	x10, _global_constant@PAGE
Lloh79:
	add	x10, x10, _global_constant@PAGEOFF
	add	x10, x10, x20, lsl #4
	ldr	x10, [x10, #8]
	lsr	x8, x10, x8
	add	x8, x8, #1
	lsr	x8, x8, #1
	cmp	x8, x9
	cinc	x21, x8, lo
	b	LBB5_36
LBB5_29:
	b.ne	LBB5_32
	sub	x0, x20, #1
	mov	x1, x23
	mov	x2, x22
	bl	"_std::builtin::_format_float::_compute_mul_parity[::DType](::SIMD[$0, ::Int(1)],::Int,::Int),CarrierDType=ui64"
	tbnz	w0, #0, LBB5_10
	tbnz	w1, #0, LBB5_10
LBB5_32:
	mov	w8, #10
	sub	x25, x27, x21, lsr #1
	mov	w9, #656
	mov	w10, #32800
	madd	w9, w25, w9, w10
	and	w10, w9, #0xfff0
	lsr	w9, w9, #16
	madd	x21, x26, x8, x9
	cmp	w10, #655
	b.hi	LBB5_36
	mov	x0, x20
	mov	x1, x23
	mov	x2, x22
	bl	"_std::builtin::_format_float::_compute_mul_parity[::DType](::SIMD[$0, ::Int(1)],::Int,::Int),CarrierDType=ui64"
	eor	w8, w0, w25
	and	x8, x8, #0x1
	sub	x21, x21, x8
	b	LBB5_36
LBB5_34:
	add	x9, x24, #1
	mov	x10, #3617
	movk	x10, #8937, lsl #16
	movk	x10, #1867, lsl #32
	movk	x10, #103, lsl #48
	mul	x10, x8, x10
	lsr	x10, x10, #8
	add	w11, w8, w8, lsl #5
	orr	x10, x10, x11, lsl #56
	mov	x11, #50274
	movk	x11, #62237, lsl #16
	movk	x11, #42, lsl #32
	cmp	x10, x11
	csel	x8, x10, x8, lo
	mov	x10, #32401
	movk	x10, #15099, lsl #16
	movk	x10, #52848, lsl #32
	movk	x10, #648, lsl #48
	mul	x10, x8, x10
	extr	x10, x8, x10, #4
	mov	w11, #2
	csel	x12, x11, xzr, lo
	mov	x13, #4300
	movk	x13, #47815, lsl #16
	movk	x13, #36280, lsl #32
	movk	x13, #6, lsl #48
	cmp	x10, x13
	csel	x8, x10, x8, lo
	cinc	x10, x12, lo
	mov	x12, #23593
	movk	x12, #49807, lsl #16
	movk	x12, #10485, lsl #32
	movk	x12, #36700, lsl #48
	mul	x12, x8, x12
	extr	x12, x8, x12, #2
	mov	x13, #36701
	movk	x13, #62914, lsl #16
	movk	x13, #23592, lsl #32
	movk	x13, #655, lsl #48
	cmp	x12, x13
	csel	x8, x12, x8, lo
	mov	x12, #-3689348814741910324
	movk	x12, #52429
	mul	x12, x8, x12
	extr	x12, x8, x12, #1
	csel	x11, x11, xzr, lo
	mov	x13, #-7378697629483820647
	movk	x13, #6553, lsl #48
	cmp	x12, x13
	csel	x21, x12, x8, ls
	add	x8, x9, x10, lsl #2
	add	x8, x8, x11
LBB5_35:
	cinc	x24, x8, ls
LBB5_36:
	cmp	x24, #0
	cneg	x8, x24, mi
Lloh80:
	adrp	x27, _static_string_ffe5c571af8dd3fc@PAGE
Lloh81:
	add	x27, x27, _static_string_ffe5c571af8dd3fc@PAGEOFF
	adrp	x26, lCPI5_0@PAGE
Lloh82:
	adrp	x23, _static_string_a0fcf35b7349c924@PAGE
Lloh83:
	add	x23, x23, _static_string_a0fcf35b7349c924@PAGEOFF
	adrp	x20, lCPI5_1@PAGE
	mov	x28, #0
	cbz	x21, LBB5_40
	ldr	q0, [x26, lCPI5_0@PAGEOFF]
	ldr	q1, [x20, lCPI5_1@PAGEOFF]
	mov	x9, #-3689348814741910324
	movk	x9, #52429
	mov	w10, #10
	add	x11, sp, #248
	mov	x12, x21
LBB5_38:
	str	x27, [sp, #64]
	stur	q0, [sp, #72]
	str	x23, [sp, #88]
	stur	q1, [sp, #96]
	cmp	x28, #21
	b.eq	LBB5_102
	umulh	x13, x12, x9
	lsr	x13, x13, #3
	msub	w14, w13, w10, w12
	strb	w14, [x11, x28]
	add	x28, x28, #1
	cmp	x12, #9
	cinc	x24, x24, hi
	mov	x12, x13
	b.hi	LBB5_38
LBB5_40:
	add	x25, sp, #184
	sub	x22, x28, #1
	sub	x10, x8, x28
	cmp	x24, #0
	sub	x9, x8, x28
	str	x9, [sp, #48]
	ccmp	x10, #3, #4, mi
	cset	w9, gt
	cmp	x24, #15
	b.gt	LBB5_50
	cbnz	w9, LBB5_50
	tbz	x24, #63, LBB5_63
	cmp	x8, x28
	b.ls	LBB5_63
	ldr	x8, [sp, #48]
	bic	x21, x8, x8, asr #63
	ldr	x2, [x19, #4096]
	add	x8, x2, #2
	cmp	x8, #1, lsl #12
	b.le	LBB5_46
	ldr	x8, [x19, #4104]
	ldr	x0, [x8]
	mov	x1, x19
	bl	_write
	mov	x2, #0
	str	xzr, [x19, #4096]
LBB5_46:
	mov	w8, #11824
	strh	w8, [x19, x2]
	ldr	x8, [x19, #4096]
	add	x2, x8, #2
	str	x2, [x19, #4096]
	cmp	x21, #0
	cset	w8, ne
	sub	x8, x21, x8
	add	x21, x8, #1
	mov	w24, #48
	b	LBB5_48
LBB5_47:
	strb	w24, [x19, x2]
	ldr	x8, [x19, #4096]
	add	x2, x8, #1
	str	x2, [x19, #4096]
	subs	x21, x21, #1
	b.eq	LBB5_75
LBB5_48:
	add	x8, x2, #1
	cmp	x8, #1, lsl #12
	b.le	LBB5_47
	ldr	x8, [x19, #4104]
	ldr	x0, [x8]
	mov	x1, x19
	bl	_write
	mov	x2, #0
	str	xzr, [x19, #4096]
	b	LBB5_47
LBB5_50:
	cmp	x21, #9
	b.hi	LBB5_52
	mov	x0, x21
	mov	x1, x19
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=ui64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"
	cmp	x28, #2
	b.ge	LBB5_56
	b	LBB5_59
LBB5_52:
	str	x27, [sp, #112]
	ldr	q0, [x26, lCPI5_0@PAGEOFF]
	stur	q0, [sp, #120]
	str	x23, [sp, #136]
	ldr	q0, [x20, lCPI5_1@PAGEOFF]
	stur	q0, [sp, #144]
	cmp	x22, #21
	b.hs	LBB5_116
	add	x8, sp, #248
	ldrb	w0, [x8, x22]
	mov	x1, x19
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=ui8,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"
	ldr	x2, [x19, #4096]
	add	x8, x2, #1
	cmp	x8, #1, lsl #12
	b.le	LBB5_55
	ldr	x8, [x19, #4104]
	ldr	x0, [x8]
	mov	x1, x19
	bl	_write
	mov	x2, #0
	str	xzr, [x19, #4096]
LBB5_55:
	mov	w8, #46
	strb	w8, [x19, x2]
	ldr	x8, [x19, #4096]
	add	x8, x8, #1
	str	x8, [x19, #4096]
	cmp	x28, #2
	b.lt	LBB5_59
LBB5_56:
	bic	x8, x22, x22, asr #63
	sub	x20, x8, #1
Lloh84:
	adrp	x8, lCPI5_0@PAGE
Lloh85:
	ldr	q0, [x8, lCPI5_0@PAGEOFF]
	str	q0, [sp, #48]
Lloh86:
	adrp	x8, lCPI5_1@PAGE
Lloh87:
	ldr	q0, [x8, lCPI5_1@PAGEOFF]
	str	q0, [sp, #32]
	add	x21, sp, #248
	mov	x26, #9223372036854775807
LBB5_57:
	str	x27, [sp, #160]
	ldp	q0, q1, [sp, #32]
	stur	q1, [sp, #168]
	str	x23, [sp, #184]
	stur	q0, [x25, #8]
	cmp	x20, #21
	b.hs	LBB5_108
	mov	x22, x27
	sub	x27, x20, #1
	ldrb	w0, [x21, x20]
	mov	x1, x19
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=ui8,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"
	cmn	x27, #1
	csinv	x8, x27, xzr, gt
	mov	x20, x27
	cmp	x8, x26
	mov	x27, x22
	b.lo	LBB5_57
LBB5_59:
	tbnz	x24, #63, LBB5_79
	ldr	x2, [x19, #4096]
	add	x8, x2, #2
	cmp	x8, #1, lsl #12
	adrp	x20, lCPI5_1@PAGE
	adrp	x21, lCPI5_0@PAGE
	b.le	LBB5_62
	ldr	x8, [x19, #4104]
	ldr	x0, [x8]
	mov	x1, x19
	bl	_write
	mov	x2, #0
	str	xzr, [x19, #4096]
LBB5_62:
	mov	w8, #11109
	strh	w8, [x19, x2]
	ldr	x8, [x19, #4096]
	add	x2, x8, #2
	str	x2, [x19, #4096]
	cmp	x24, #10
	b.lt	LBB5_82
	b	LBB5_85
LBB5_63:
	cmp	x28, #1
	b.lt	LBB5_92
	mov	x27, #0
	mov	w21, #0
	ldr	q0, [x26, lCPI5_0@PAGEOFF]
	str	q0, [sp, #32]
	ldr	q0, [x20, lCPI5_1@PAGEOFF]
	str	q0, [sp, #16]
LBB5_65:
	ldr	x8, [sp, #48]
	cmp	x8, #1
	add	x8, x24, #1
	ccmp	x8, x27, #0, lt
	cset	w26, eq
	b.ne	LBB5_70
	ldr	x2, [x19, #4096]
	cbz	x27, LBB5_72
	add	x8, x2, #1
	cmp	x8, #1, lsl #12
	b.le	LBB5_69
LBB5_68:
	ldr	x8, [x19, #4104]
	ldr	x0, [x8]
	mov	x1, x19
	bl	_write
	mov	x2, #0
	str	xzr, [x19, #4096]
LBB5_69:
	mov	w8, #46
	strb	w8, [x19, x2]
	ldr	x8, [x19, #4096]
	add	x8, x8, #1
	str	x8, [x19, #4096]
LBB5_70:
Lloh88:
	adrp	x8, _static_string_ffe5c571af8dd3fc@PAGE
Lloh89:
	add	x8, x8, _static_string_ffe5c571af8dd3fc@PAGEOFF
	str	x8, [sp, #272]
	ldp	q0, q1, [sp, #16]
	stur	q1, [x25, #96]
	str	x23, [sp, #296]
	stur	q0, [x25, #120]
	cmp	x22, #21
	b.hs	LBB5_110
	sub	x20, x22, #1
	orr	w21, w26, w21
	add	x8, sp, #248
	ldrb	w0, [x8, x22]
	mov	x1, x19
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=ui8,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"
	cmn	x20, #1
	csinv	x8, x20, xzr, gt
	add	x27, x27, #1
	mov	x22, x20
	mov	x9, #9223372036854775807
	cmp	x8, x9
	b.lo	LBB5_65
	b	LBB5_93
LBB5_72:
	add	x8, x2, #1
	cmp	x8, #1, lsl #12
	b.le	LBB5_74
	ldr	x8, [x19, #4104]
	ldr	x0, [x8]
	mov	x1, x19
	bl	_write
	mov	x2, #0
	str	xzr, [x19, #4096]
LBB5_74:
	mov	w8, #48
	strb	w8, [x19, x2]
	ldr	x8, [x19, #4096]
	add	x2, x8, #1
	str	x2, [x19, #4096]
	add	x8, x2, #1
	cmp	x8, #1, lsl #12
	b.gt	LBB5_68
	b	LBB5_69
LBB5_75:
	cmp	x28, #1
	b.lt	LBB5_23
	ldr	q0, [x26, lCPI5_0@PAGEOFF]
	str	q0, [sp, #48]
	ldr	q0, [x20, lCPI5_1@PAGEOFF]
	str	q0, [sp, #32]
	add	x21, sp, #248
	mov	x24, #9223372036854775807
LBB5_77:
	str	x27, [sp, #272]
	ldp	q0, q1, [sp, #32]
	stur	q1, [x25, #96]
	str	x23, [sp, #296]
	stur	q0, [x25, #120]
	cmp	x22, #21
	b.hs	LBB5_112
	sub	x26, x22, #1
	ldrb	w0, [x21, x22]
	mov	x1, x19
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=ui8,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"
	cmn	x26, #1
	csinv	x8, x26, xzr, gt
	mov	x22, x26
	cmp	x8, x24
	b.lo	LBB5_77
	b	LBB5_23
LBB5_79:
	ldr	x2, [x19, #4096]
	add	x8, x2, #2
	cmp	x8, #1, lsl #12
	adrp	x20, lCPI5_1@PAGE
	adrp	x21, lCPI5_0@PAGE
	b.le	LBB5_81
	ldr	x8, [x19, #4104]
	ldr	x0, [x8]
	mov	x1, x19
	bl	_write
	mov	x2, #0
	str	xzr, [x19, #4096]
LBB5_81:
	mov	w8, #11621
	strh	w8, [x19, x2]
	ldr	x8, [x19, #4096]
	add	x2, x8, #2
	str	x2, [x19, #4096]
	neg	x24, x24
	cmp	x24, #10
	b.ge	LBB5_85
LBB5_82:
	add	x8, x2, #1
	cmp	x8, #1, lsl #12
	b.le	LBB5_84
	ldr	x8, [x19, #4104]
	ldr	x0, [x8]
	mov	x1, x19
	bl	_write
	mov	x2, #0
	str	xzr, [x19, #4096]
LBB5_84:
	mov	w8, #48
	strb	w8, [x19, x2]
	ldr	x8, [x19, #4096]
	add	x8, x8, #1
	str	x8, [x19, #4096]
	cmp	x24, #1
	b.lt	LBB5_23
LBB5_85:
	mov	x8, #0
	ldr	q0, [x21, lCPI5_0@PAGEOFF]
	ldr	q1, [x20, lCPI5_1@PAGEOFF]
	mov	x9, #-3689348814741910324
	movk	x9, #52429
	mov	w10, #10
	add	x11, sp, #214
LBB5_86:
	str	x27, [sp, #224]
	stur	q0, [x25, #48]
	str	x23, [sp, #248]
	stur	q1, [x25, #72]
	cmp	x8, #10
	b.eq	LBB5_104
	umulh	x12, x24, x9
	lsr	x12, x12, #3
	msub	w13, w12, w10, w24
	strb	w13, [x11, x8]
	add	x8, x8, #1
	cmp	x24, #9
	mov	x24, x12
	b.hi	LBB5_86
	mov	x9, #-9223372036854775808
	cmp	x8, x9
	b.eq	LBB5_23
	sub	x20, x8, #1
	add	x21, sp, #214
	mov	x24, #9223372036854775807
	stp	q1, q0, [sp, #32]
LBB5_90:
	str	x27, [sp, #272]
	stur	q0, [x25, #96]
	str	x23, [sp, #296]
	stur	q1, [x25, #120]
	cmp	x20, #10
	b.hs	LBB5_106
	sub	x26, x20, #1
	ldrb	w0, [x21, x20]
	mov	x1, x19
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=ui8,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"
	cmn	x26, #1
	csinv	x8, x26, xzr, gt
	mov	x20, x26
	cmp	x8, x24
	ldp	q1, q0, [sp, #32]
	b.lo	LBB5_90
	b	LBB5_23
LBB5_92:
	mov	w21, #0
LBB5_93:
	mov	x8, #9223372036854775806
	sub	x9, x24, x28
	cmp	x9, x8
	b.ls	LBB5_98
LBB5_94:
	tbnz	w21, #0, LBB5_23
	ldr	x2, [x19, #4096]
	add	x8, x2, #2
	cmp	x8, #1, lsl #12
	b.le	LBB5_97
	ldr	x8, [x19, #4104]
	ldr	x0, [x8]
	mov	x1, x19
	bl	_write
	mov	x2, #0
	str	xzr, [x19, #4096]
LBB5_97:
	mov	w8, #12334
	strh	w8, [x19, x2]
	ldr	x8, [x19, #4096]
	add	x8, x8, #2
	b	LBB5_22
LBB5_98:
	ldr	x2, [x19, #4096]
	mvn	x8, x24
	add	x20, x8, x28
	mov	w22, #48
	b	LBB5_100
LBB5_99:
	strb	w22, [x19, x2]
	ldr	x8, [x19, #4096]
	add	x2, x8, #1
	str	x2, [x19, #4096]
	adds	x20, x20, #1
	b.hs	LBB5_94
LBB5_100:
	add	x8, x2, #1
	cmp	x8, #1, lsl #12
	b.le	LBB5_99
	ldr	x8, [x19, #4104]
	ldr	x0, [x8]
	mov	x1, x19
	bl	_write
	mov	x2, #0
	str	xzr, [x19, #4096]
	b	LBB5_99
LBB5_102:
	add	x0, sp, #64
	add	x1, sp, #320
	mov	x2, #0
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	mov	w0, #21
	mov	x1, x2
	mov	x2, x3
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	add	x0, sp, #88
	mov	x1, x2
	mov	x2, x3
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	mov	w0, #20
	mov	x1, x2
	mov	x2, x3
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	add	x8, x1, #1
	cmp	x8, #2049
	b.ge	LBB5_113
	strb	wzr, [x0, x1]
Lloh90:
	adrp	x3, _static_string_cfa776fe0f373673@PAGE
Lloh91:
	add	x3, x3, _static_string_cfa776fe0f373673@PAGEOFF
	mov	w1, #263
	mov	w2, #19
	mov	w4, #54
	bl	"_std::builtin::debug_assert::_debug_assert_msg[LITImmutOrigin,::Origin[::Bool(False), $0]](::UnsafePointer[::Bool(False), $0, ::SIMD[::DType(uint8), ::Int(1)], $1, ::AddressSpace(::Int(0))],::Int,::SourceLocation)"
LBB5_104:
	add	x0, sp, #224
	add	x1, sp, #320
	mov	x2, #0
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	mov	w0, #10
	mov	x1, x2
	mov	x2, x3
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	add	x0, sp, #248
	mov	x1, x2
	mov	x2, x3
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	mov	w0, #9
	mov	x1, x2
	mov	x2, x3
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	add	x8, x1, #1
	cmp	x8, #2049
	b.ge	LBB5_113
	strb	wzr, [x0, x1]
Lloh92:
	adrp	x3, _static_string_cfa776fe0f373673@PAGE
Lloh93:
	add	x3, x3, _static_string_cfa776fe0f373673@PAGEOFF
	mov	w1, #294
	mov	w2, #27
	mov	w4, #54
	bl	"_std::builtin::debug_assert::_debug_assert_msg[LITImmutOrigin,::Origin[::Bool(False), $0]](::UnsafePointer[::Bool(False), $0, ::SIMD[::DType(uint8), ::Int(1)], $1, ::AddressSpace(::Int(0))],::Int,::SourceLocation)"
LBB5_106:
	add	x0, sp, #272
	add	x1, sp, #320
	mov	x2, #0
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	mov	x0, x20
	mov	x1, x2
	mov	x2, x3
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	add	x0, sp, #296
	mov	x1, x2
	mov	x2, x3
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	mov	w0, #9
	mov	x1, x2
	mov	x2, x3
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	add	x8, x1, #1
	cmp	x8, #2049
	b.ge	LBB5_113
	strb	wzr, [x0, x1]
Lloh94:
	adrp	x3, _static_string_cfa776fe0f373673@PAGE
Lloh95:
	add	x3, x3, _static_string_cfa776fe0f373673@PAGEOFF
	mov	w1, #298
	mov	w2, #40
	mov	w4, #54
	bl	"_std::builtin::debug_assert::_debug_assert_msg[LITImmutOrigin,::Origin[::Bool(False), $0]](::UnsafePointer[::Bool(False), $0, ::SIMD[::DType(uint8), ::Int(1)], $1, ::AddressSpace(::Int(0))],::Int,::SourceLocation)"
LBB5_108:
	add	x0, sp, #160
	add	x1, sp, #320
	mov	x2, #0
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	mov	x0, x20
	mov	x1, x2
	mov	x2, x3
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	add	x0, sp, #184
	mov	x1, x2
	mov	x2, x3
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	mov	w0, #20
	mov	x1, x2
	mov	x2, x3
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	add	x8, x1, #1
	cmp	x8, #2049
	b.ge	LBB5_113
	strb	wzr, [x0, x1]
Lloh96:
	adrp	x3, _static_string_cfa776fe0f373673@PAGE
Lloh97:
	add	x3, x3, _static_string_cfa776fe0f373673@PAGEOFF
	mov	w1, #281
	mov	w2, #36
	mov	w4, #54
	bl	"_std::builtin::debug_assert::_debug_assert_msg[LITImmutOrigin,::Origin[::Bool(False), $0]](::UnsafePointer[::Bool(False), $0, ::SIMD[::DType(uint8), ::Int(1)], $1, ::AddressSpace(::Int(0))],::Int,::SourceLocation)"
LBB5_110:
	add	x0, sp, #272
	add	x1, sp, #320
	mov	x2, #0
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	mov	x0, x22
	mov	x1, x2
	mov	x2, x3
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	add	x0, sp, #296
	mov	x1, x2
	mov	x2, x3
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	mov	w0, #20
	mov	x1, x2
	mov	x2, x3
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	add	x8, x1, #1
	cmp	x8, #2049
	b.ge	LBB5_113
	strb	wzr, [x0, x1]
Lloh98:
	adrp	x3, _static_string_cfa776fe0f373673@PAGE
Lloh99:
	add	x3, x3, _static_string_cfa776fe0f373673@PAGEOFF
	mov	w1, #316
	mov	w2, #36
	mov	w4, #54
	bl	"_std::builtin::debug_assert::_debug_assert_msg[LITImmutOrigin,::Origin[::Bool(False), $0]](::UnsafePointer[::Bool(False), $0, ::SIMD[::DType(uint8), ::Int(1)], $1, ::AddressSpace(::Int(0))],::Int,::SourceLocation)"
LBB5_112:
	add	x0, sp, #272
	add	x1, sp, #320
	mov	x2, #0
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	mov	x0, x22
	mov	x1, x2
	mov	x2, x3
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	add	x0, sp, #296
	mov	x1, x2
	mov	x2, x3
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	mov	w0, #20
	mov	x1, x2
	mov	x2, x3
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	add	x8, x1, #1
	cmp	x8, #2049
	b.lt	LBB5_114
LBB5_113:
	mov	w0, #1
	bl	"_std::io::io::_printf[KGENParamList[::AnyType],::StringSlice[::Bool(False), StaticConstantOrigin, *?],*::AnyType,LITImmutOrigin,::Origin[::Bool(False), $3]](*$0,file:::FileDescriptor),types.values`=[],fmt={ #interp.memref<{[(#interp.memory_handle<16, \"HEAP_BUFFER_BYTES exceeded, increase with: `mojo -D HEAP_BUFFER_BYTES=4096`\\0A\\00\" string>, const_global, [], [])], []}, 0, 0>, 76 }"
	brk	#0x1
LBB5_114:
	strb	wzr, [x0, x1]
Lloh100:
	adrp	x3, _static_string_cfa776fe0f373673@PAGE
Lloh101:
	add	x3, x3, _static_string_cfa776fe0f373673@PAGEOFF
	mov	w1, #305
	mov	w2, #36
	mov	w4, #54
	bl	"_std::builtin::debug_assert::_debug_assert_msg[LITImmutOrigin,::Origin[::Bool(False), $0]](::UnsafePointer[::Bool(False), $0, ::SIMD[::DType(uint8), ::Int(1)], $1, ::AddressSpace(::Int(0))],::Int,::SourceLocation)"
LBB5_115:
Lloh102:
	adrp	x1, _static_string_e5411518d45eb182@PAGE
Lloh103:
	add	x1, x1, _static_string_e5411518d45eb182@PAGEOFF
	mov	x0, x19
	mov	w2, #3
	add	sp, sp, #2368
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	b	"_std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"
LBB5_116:
	add	x0, sp, #112
	add	x1, sp, #320
	mov	x2, #0
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	mov	x0, x22
	mov	x1, x2
	mov	x2, x3
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	add	x0, sp, #136
	mov	x1, x2
	mov	x2, x3
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	mov	w0, #20
	mov	x1, x2
	mov	x2, x3
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	add	x8, x1, #1
	cmp	x8, #2049
	b.ge	LBB5_113
	strb	wzr, [x0, x1]
Lloh104:
	adrp	x3, _static_string_cfa776fe0f373673@PAGE
Lloh105:
	add	x3, x3, _static_string_cfa776fe0f373673@PAGEOFF
	mov	w1, #277
	mov	w2, #36
	mov	w4, #54
	bl	"_std::builtin::debug_assert::_debug_assert_msg[LITImmutOrigin,::Origin[::Bool(False), $0]](::UnsafePointer[::Bool(False), $0, ::SIMD[::DType(uint8), ::Int(1)], $1, ::AddressSpace(::Int(0))],::Int,::SourceLocation)"
	.loh AdrpAdd	Lloh76, Lloh77
	.loh AdrpAdd	Lloh78, Lloh79
	.loh AdrpAdd	Lloh82, Lloh83
	.loh AdrpAdd	Lloh80, Lloh81
	.loh AdrpLdr	Lloh86, Lloh87
	.loh AdrpAdrp	Lloh84, Lloh86
	.loh AdrpLdr	Lloh84, Lloh85
	.loh AdrpAdd	Lloh88, Lloh89
	.loh AdrpAdd	Lloh90, Lloh91
	.loh AdrpAdd	Lloh92, Lloh93
	.loh AdrpAdd	Lloh94, Lloh95
	.loh AdrpAdd	Lloh96, Lloh97
	.loh AdrpAdd	Lloh98, Lloh99
	.loh AdrpAdd	Lloh100, Lloh101
	.loh AdrpAdd	Lloh102, Lloh103
	.loh AdrpAdd	Lloh104, Lloh105
	.cfi_endproc

	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0
lCPI6_0:
	.quad	1
	.quad	2305843009213693952
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	2
"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]":
	.cfi_startproc
	sub	sp, sp, #144
	stp	x24, x23, [sp, #80]
	stp	x22, x21, [sp, #96]
	stp	x20, x19, [sp, #112]
	stp	x29, x30, [sp, #128]
	.cfi_def_cfa_offset 144
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	cbz	x0, LBB6_7
	tbz	x0, #63, LBB6_3
Lloh106:
	adrp	x8, _static_string_a8e3dd8c929b6eb8@PAGE
Lloh107:
	add	x8, x8, _static_string_a8e3dd8c929b6eb8@PAGEOFF
	str	x8, [sp, #8]
Lloh108:
	adrp	x8, lCPI6_0@PAGE
Lloh109:
	ldr	q0, [x8, lCPI6_0@PAGEOFF]
	stur	q0, [sp, #16]
	mov	x19, x0
	add	x0, sp, #8
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x8, x0
	mov	x0, x19
	mov	x2, x1
	mov	x1, x8
LBB6_3:
	cmp	x2, #2049
	b.ge	LBB6_26
	strb	wzr, [sp, #72]
	mov	w8, #63
	tbnz	x0, #63, LBB6_10
	mov	x9, #-3689348814741910324
	movk	x9, #52429
	mov	x10, #-10
	add	x11, sp, #8
Lloh110:
	adrp	x12, _static_string_978d8d34847e5196@PAGE
Lloh111:
	add	x12, x12, _static_string_978d8d34847e5196@PAGEOFF
LBB6_6:
	mov	x13, x0
	umulh	x14, x0, x9
	lsr	x0, x14, #3
	madd	x14, x0, x10, x12
	ldrb	w14, [x14, x13]
	strb	w14, [x11, x8]
	sub	x8, x8, #1
	cmp	x13, #10
	b.hs	LBB6_6
	b	LBB6_12
LBB6_7:
	cmp	x2, #2048
	b.gt	LBB6_26
	cmp	x2, #2048
	b.eq	LBB6_26
	mov	w8, #48
	strb	w8, [x1, x2]
	add	x19, x2, #1
	b	LBB6_14
LBB6_10:
	mov	x9, #-7378697629483820647
	mov	x10, #-10
	add	x11, sp, #8
Lloh112:
	adrp	x12, _static_string_978d8d34847e5196@PAGE
Lloh113:
	add	x12, x12, _static_string_978d8d34847e5196@PAGEOFF
LBB6_11:
	smulh	x13, x0, x9
	asr	x14, x13, #2
	add	x13, x14, x13, lsr #63
	mul	x14, x13, x10
	cmn	x0, #1
	cset	w15, gt
	subs	x14, x0, x14
	cset	w16, ne
	ands	w15, w15, w16
	csel	x16, x10, xzr, ne
	adds	x14, x14, x16
	cneg	x14, x14, mi
	ldrb	w14, [x12, x14]
	strb	w14, [x11, x8]
	sub	x8, x8, #1
	subs	x0, x15, x13
	b.ne	LBB6_11
LBB6_12:
	add	x9, x8, #1
	add	x10, x8, #66
	bic	x10, x10, x10, asr #63
	cmp	x9, #65
	mov	w11, #65
	csinc	x8, x11, x8, ge
	cmp	x9, #0
	csel	x8, x10, x8, mi
	mov	w9, #64
	sub	x22, x9, x8
	add	x19, x22, x2
	cmp	x19, #2049
	b.ge	LBB6_26
	cmp	x8, #64
	b.ne	LBB6_15
LBB6_14:
	mov	x0, x1
	mov	x1, x19
	ldp	x29, x30, [sp, #128]
	ldp	x20, x19, [sp, #112]
	ldp	x22, x21, [sp, #96]
	ldp	x24, x23, [sp, #80]
	add	sp, sp, #144
	ret
LBB6_15:
	add	x20, x1, x2
	add	x9, sp, #8
	add	x21, x9, x8
	cmp	x22, #4
	b.gt	LBB6_18
	mov	w9, #63
	sub	x9, x9, x8
	ldrb	w10, [x21]
	strb	w10, [x20]
	ldrb	w10, [sp, #71]
	strb	w10, [x20, x9]
	cmp	x22, #3
	b.lt	LBB6_14
	mov	w9, #62
	sub	x8, x9, x8
	ldrb	w9, [x21, #1]
	strb	w9, [x20, #1]
	ldrb	w9, [sp, #70]
	strb	w9, [x20, x8]
	b	LBB6_14
LBB6_18:
	cmp	x22, #16
	b.gt	LBB6_21
	add	x8, x20, x22
	cmp	x22, #8
	b.lt	LBB6_25
	ldr	x9, [x21]
	str	x9, [x20]
	ldr	x9, [sp, #64]
	stur	x9, [x8, #-8]
	b	LBB6_14
LBB6_21:
	ands	x23, x22, #0x7fffffffffffffe0
	b.eq	LBB6_23
	mov	w9, #32
	sub	x8, x9, x8
	and	x8, x8, #0xffffffffffffffe0
	add	x2, x8, #32
	mov	x0, x20
	mov	x24, x1
	mov	x1, x21
	bl	_memcpy
	mov	x1, x24
LBB6_23:
	cmp	x23, x22
	b.eq	LBB6_14
	add	x0, x20, x23
	mov	x20, x1
	add	x1, x21, x23
	and	x2, x22, #0x1f
	bl	_memcpy
	mov	x1, x20
	b	LBB6_14
LBB6_25:
	ldr	w9, [x21]
	str	w9, [x20]
	ldr	w9, [sp, #68]
	stur	w9, [x8, #-4]
	b	LBB6_14
LBB6_26:
	mov	w0, #1
	bl	"_std::io::io::_printf[KGENParamList[::AnyType],::StringSlice[::Bool(False), StaticConstantOrigin, *?],*::AnyType,LITImmutOrigin,::Origin[::Bool(False), $3]](*$0,file:::FileDescriptor),types.values`=[],fmt={ #interp.memref<{[(#interp.memory_handle<16, \"HEAP_BUFFER_BYTES exceeded, increase with: `mojo -D HEAP_BUFFER_BYTES=4096`\\0A\\00\" string>, const_global, [], [])], []}, 0, 0>, 76 }"
	brk	#0x1
	.loh AdrpLdr	Lloh108, Lloh109
	.loh AdrpAdd	Lloh106, Lloh107
	.loh AdrpAdd	Lloh110, Lloh111
	.loh AdrpAdd	Lloh112, Lloh113
	.cfi_endproc

	.p2align	2
"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]":
	.cfi_startproc
	sub	sp, sp, #112
	stp	x20, x19, [sp, #80]
	stp	x29, x30, [sp, #96]
	.cfi_def_cfa_offset 112
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	x19, x1
	mov	x20, x0
	ldr	x2, [x1, #4096]
	tbnz	x0, #63, LBB7_4
	cmp	x2, #1, lsl #12
	b.le	LBB7_10
	ldr	x8, [x19, #4104]
	ldr	x0, [x8]
	mov	x1, x19
	bl	_write
	str	xzr, [x19, #4096]
	cbnz	x20, LBB7_11
	mov	x2, #0
	b	LBB7_16
LBB7_4:
	add	x8, x2, #1
	cmp	x8, #1, lsl #12
	b.le	LBB7_6
	ldr	x8, [x19, #4104]
	ldr	x0, [x8]
	mov	x1, x19
	bl	_write
	mov	x2, #0
	str	xzr, [x19, #4096]
LBB7_6:
	mov	w8, #45
	strb	w8, [x19, x2]
	ldr	x8, [x19, #4096]
	add	x2, x8, #1
	str	x2, [x19, #4096]
	cmp	x2, #1, lsl #12
	b.le	LBB7_8
	ldr	x8, [x19, #4104]
	ldr	x0, [x8]
	mov	x1, x19
	bl	_write
	str	xzr, [x19, #4096]
LBB7_8:
	mov	x8, #0
	strb	wzr, [sp, #79]
	add	x9, sp, #15
	add	x9, x9, #63
	mov	x10, #-7378697629483820647
	mov	x11, #-10
Lloh114:
	adrp	x12, _static_string_978d8d34847e5196@PAGE
Lloh115:
	add	x12, x12, _static_string_978d8d34847e5196@PAGEOFF
LBB7_9:
	smulh	x13, x20, x10
	asr	x14, x13, #2
	add	x13, x14, x13, lsr #63
	mul	x14, x13, x11
	cmn	x20, #1
	cset	w15, gt
	subs	x14, x20, x14
	cset	w16, ne
	ands	w15, w15, w16
	csel	x16, x11, xzr, ne
	adds	x14, x14, x16
	cneg	x14, x14, mi
	ldrb	w14, [x12, x14]
	strb	w14, [x9, x8]
	sub	x8, x8, #1
	sub	x20, x15, x13
	cbnz	x20, LBB7_9
	b	LBB7_13
LBB7_10:
	cbz	x20, LBB7_14
LBB7_11:
	mov	x8, #0
	strb	wzr, [sp, #79]
	add	x9, sp, #15
	add	x9, x9, #63
	mov	x10, #-3689348814741910324
	movk	x10, #52429
	mov	x11, #-10
Lloh116:
	adrp	x12, _static_string_978d8d34847e5196@PAGE
Lloh117:
	add	x12, x12, _static_string_978d8d34847e5196@PAGEOFF
LBB7_12:
	mov	x13, x20
	umulh	x14, x20, x10
	lsr	x20, x14, #3
	madd	x14, x20, x11, x12
	ldrb	w14, [x14, x13]
	strb	w14, [x9, x8]
	sub	x8, x8, #1
	cmp	x13, #9
	b.hi	LBB7_12
LBB7_13:
	add	x9, x8, #129
	bic	x9, x9, x9, asr #63
	add	x8, x8, #64
	mov	w10, #65
	cmp	x8, #65
	csel	x10, x8, x10, lt
	cmp	x8, #0
	csel	x8, x9, x10, mi
	add	x9, sp, #15
	mov	w10, #64
	sub	x2, x10, x8
	add	x1, x9, x8
	mov	x0, x19
	bl	"_std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=1"
	ldp	x29, x30, [sp, #96]
	ldp	x20, x19, [sp, #80]
	add	sp, sp, #112
	ret
LBB7_14:
	cmp	x2, #1, lsl #12
	b.ne	LBB7_16
	ldr	x8, [x19, #4104]
	ldr	x0, [x8]
	mov	x1, x19
	bl	_write
	mov	x2, #0
	str	xzr, [x19, #4096]
LBB7_16:
	mov	w8, #48
	strb	w8, [x19, x2]
	ldr	x8, [x19, #4096]
	add	x8, x8, #1
	str	x8, [x19, #4096]
	ldp	x29, x30, [sp, #96]
	ldp	x20, x19, [sp, #80]
	add	sp, sp, #112
	ret
	.loh AdrpAdd	Lloh114, Lloh115
	.loh AdrpAdd	Lloh116, Lloh117
	.cfi_endproc

	.p2align	2
"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=ui64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]":
	.cfi_startproc
	sub	sp, sp, #112
	stp	x20, x19, [sp, #80]
	stp	x29, x30, [sp, #96]
	.cfi_def_cfa_offset 112
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	x19, x1
	ldr	x2, [x1, #4096]
	cmp	x2, #1, lsl #12
	cbz	x0, LBB8_6
	b.le	LBB8_3
	ldr	x8, [x19, #4104]
	ldr	x8, [x8]
	mov	x20, x0
	mov	x0, x8
	mov	x1, x19
	bl	_write
	mov	x0, x20
	str	xzr, [x19, #4096]
LBB8_3:
	mov	x8, #0
	strb	wzr, [sp, #79]
	add	x9, sp, #15
	add	x9, x9, #63
	mov	x10, #-3689348814741910324
	movk	x10, #52429
	mov	w11, #10
Lloh118:
	adrp	x12, _static_string_978d8d34847e5196@PAGE
Lloh119:
	add	x12, x12, _static_string_978d8d34847e5196@PAGEOFF
LBB8_4:
	mov	x13, x0
	umulh	x14, x0, x10
	lsr	x0, x14, #3
	msub	x14, x0, x11, x13
	ldrb	w14, [x12, x14]
	strb	w14, [x9, x8]
	sub	x8, x8, #1
	cmp	x13, #9
	b.hi	LBB8_4
	add	x9, x8, #129
	bic	x9, x9, x9, asr #63
	add	x8, x8, #64
	mov	w10, #65
	cmp	x8, #65
	csel	x10, x8, x10, lt
	cmp	x8, #0
	csel	x8, x9, x10, mi
	add	x9, sp, #15
	mov	w10, #64
	sub	x2, x10, x8
	add	x1, x9, x8
	mov	x0, x19
	bl	"_std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=1"
	ldp	x29, x30, [sp, #96]
	ldp	x20, x19, [sp, #80]
	add	sp, sp, #112
	ret
LBB8_6:
	mov	w8, #4097
	ccmp	x2, x8, #0, ne
	b.lt	LBB8_8
	ldr	x8, [x19, #4104]
	ldr	x0, [x8]
	mov	x1, x19
	bl	_write
	mov	x2, #0
	str	xzr, [x19, #4096]
LBB8_8:
	mov	w8, #48
	strb	w8, [x19, x2]
	ldr	x8, [x19, #4096]
	add	x8, x8, #1
	str	x8, [x19, #4096]
	ldp	x29, x30, [sp, #96]
	ldp	x20, x19, [sp, #80]
	add	sp, sp, #112
	ret
	.loh AdrpAdd	Lloh118, Lloh119
	.cfi_endproc

	.p2align	2
"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=ui8,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]":
	.cfi_startproc
	sub	sp, sp, #112
	stp	x20, x19, [sp, #80]
	stp	x29, x30, [sp, #96]
	.cfi_def_cfa_offset 112
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	x19, x1
	ldr	x2, [x1, #4096]
	tst	w0, #0xff
	b.eq	LBB9_6
	cmp	x2, #1, lsl #12
	b.le	LBB9_3
	ldr	x8, [x19, #4104]
	ldr	x8, [x8]
	mov	x20, x0
	mov	x0, x8
	mov	x1, x19
	bl	_write
	mov	x0, x20
	str	xzr, [x19, #4096]
LBB9_3:
	mov	x8, #0
	strb	wzr, [sp, #79]
	add	x9, sp, #15
	add	x9, x9, #63
	mov	w10, #205
	mov	w11, #10
Lloh120:
	adrp	x12, _static_string_978d8d34847e5196@PAGE
Lloh121:
	add	x12, x12, _static_string_978d8d34847e5196@PAGEOFF
LBB9_4:
	mov	x13, x0
	and	w14, w0, #0xff
	mul	w15, w14, w10
	lsr	w0, w15, #11
	msub	w13, w0, w11, w13
	and	x13, x13, #0xff
	ldrb	w13, [x12, x13]
	strb	w13, [x9, x8]
	sub	x8, x8, #1
	cmp	w14, #9
	b.hi	LBB9_4
	add	x9, x8, #129
	bic	x9, x9, x9, asr #63
	add	x8, x8, #64
	mov	w10, #65
	cmp	x8, #65
	csel	x10, x8, x10, lt
	cmp	x8, #0
	csel	x8, x9, x10, mi
	add	x9, sp, #15
	mov	w10, #64
	sub	x2, x10, x8
	add	x1, x9, x8
	mov	x0, x19
	bl	"_std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=1"
	ldp	x29, x30, [sp, #96]
	ldp	x20, x19, [sp, #80]
	add	sp, sp, #112
	ret
LBB9_6:
	cmp	x2, #1, lsl #12
	mov	w8, #4097
	ccmp	x2, x8, #0, ne
	b.lt	LBB9_8
	ldr	x8, [x19, #4104]
	ldr	x0, [x8]
	mov	x1, x19
	bl	_write
	mov	x2, #0
	str	xzr, [x19, #4096]
LBB9_8:
	mov	w8, #48
	strb	w8, [x19, x2]
	ldr	x8, [x19, #4096]
	add	x8, x8, #1
	str	x8, [x19, #4096]
	ldp	x29, x30, [sp, #96]
	ldp	x20, x19, [sp, #80]
	add	sp, sp, #112
	ret
	.loh AdrpAdd	Lloh120, Lloh121
	.cfi_endproc

	.p2align	2
"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=uindex,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]":
	.cfi_startproc
	sub	sp, sp, #112
	stp	x20, x19, [sp, #80]
	stp	x29, x30, [sp, #96]
	.cfi_def_cfa_offset 112
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	x19, x1
	ldr	x2, [x1, #4096]
	cmp	x2, #1, lsl #12
	cbz	x0, LBB10_6
	b.le	LBB10_3
	ldr	x8, [x19, #4104]
	ldr	x8, [x8]
	mov	x20, x0
	mov	x0, x8
	mov	x1, x19
	bl	_write
	mov	x0, x20
	str	xzr, [x19, #4096]
LBB10_3:
	mov	x8, #0
	strb	wzr, [sp, #79]
	add	x9, sp, #15
	add	x9, x9, #63
	mov	x10, #-3689348814741910324
	movk	x10, #52429
	mov	w11, #10
Lloh122:
	adrp	x12, _static_string_978d8d34847e5196@PAGE
Lloh123:
	add	x12, x12, _static_string_978d8d34847e5196@PAGEOFF
LBB10_4:
	mov	x13, x0
	umulh	x14, x0, x10
	lsr	x0, x14, #3
	msub	x14, x0, x11, x13
	ldrb	w14, [x12, x14]
	strb	w14, [x9, x8]
	sub	x8, x8, #1
	cmp	x13, #9
	b.hi	LBB10_4
	add	x9, x8, #129
	bic	x9, x9, x9, asr #63
	add	x8, x8, #64
	mov	w10, #65
	cmp	x8, #65
	csel	x10, x8, x10, lt
	cmp	x8, #0
	csel	x8, x9, x10, mi
	add	x9, sp, #15
	mov	w10, #64
	sub	x2, x10, x8
	add	x1, x9, x8
	mov	x0, x19
	bl	"_std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=1"
	ldp	x29, x30, [sp, #96]
	ldp	x20, x19, [sp, #80]
	add	sp, sp, #112
	ret
LBB10_6:
	mov	w8, #4097
	ccmp	x2, x8, #0, ne
	b.lt	LBB10_8
	ldr	x8, [x19, #4104]
	ldr	x0, [x8]
	mov	x1, x19
	bl	_write
	mov	x2, #0
	str	xzr, [x19, #4096]
LBB10_8:
	mov	w8, #48
	strb	w8, [x19, x2]
	ldr	x8, [x19, #4096]
	add	x8, x8, #1
	str	x8, [x19, #4096]
	ldp	x29, x30, [sp, #96]
	ldp	x20, x19, [sp, #80]
	add	sp, sp, #112
	ret
	.loh AdrpAdd	Lloh122, Lloh123
	.cfi_endproc

	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0
lCPI11_0:
	.quad	37
	.quad	2305843009213693952
lCPI11_1:
	.quad	1
	.quad	2305843009213693952
lCPI11_2:
	.quad	2
	.quad	2305843009213693952
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	2
"_std::collections::list::List::_realloc(::List[$0]&,::Int),T=[typevalue<#kgen.instref<\"std::builtin::simd::SIMD,dtype=f64,size=1\">>, scalar<f64>]":
	.cfi_startproc
	sub	sp, sp, #208
	stp	x26, x25, [sp, #128]
	stp	x24, x23, [sp, #144]
	stp	x22, x21, [sp, #160]
	stp	x20, x19, [sp, #176]
	stp	x29, x30, [sp, #192]
	.cfi_def_cfa_offset 208
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	mov	x19, x3
	mov	x22, x2
	mov	x20, x1
	mov	x21, x0
	lsl	x1, x3, #3
	mov	w0, #8
	bl	_KGEN_CompilerRT_AlignedAlloc
	cbz	x0, LBB11_17
	mov	x23, x0
	cbz	x20, LBB11_13
	lsl	x24, x20, #3
	cmp	x24, #4
	b.gt	LBB11_6
	cbz	x24, LBB11_13
	sub	x8, x24, #1
	ldrb	w9, [x21]
	strb	w9, [x23]
	ldrb	w9, [x21, x8]
	strb	w9, [x23, x8]
	cmp	x24, #3
	b.lt	LBB11_13
	sub	x8, x24, #2
	ldrb	w9, [x21, #1]
	strb	w9, [x23, #1]
	ldrb	w9, [x21, x8]
	strb	w9, [x23, x8]
	cmp	x22, #1
	b.ge	LBB11_14
	b	LBB11_15
LBB11_6:
	cmp	x24, #16
	b.gt	LBB11_9
	add	x8, x23, x24
	add	x9, x21, x24
	cmp	x24, #8
	b.lt	LBB11_16
	ldr	x10, [x21]
	str	x10, [x23]
	ldur	x9, [x9, #-8]
	stur	x9, [x8, #-8]
	cmp	x22, #1
	b.ge	LBB11_14
	b	LBB11_15
LBB11_9:
	ands	x25, x24, #0x7fffffffffffffe0
	b.eq	LBB11_11
	and	x2, x24, #0x7fffffffffffffe0
	mov	x0, x23
	mov	x1, x21
	bl	_memcpy
LBB11_11:
	cmp	x25, x24
	b.eq	LBB11_13
	add	x0, x23, x25
	add	x1, x21, x25
	and	x2, x24, #0x18
	bl	_memcpy
LBB11_13:
	cmp	x22, #1
	b.lt	LBB11_15
LBB11_14:
	mov	x0, x21
	bl	_KGEN_CompilerRT_AlignedFree
LBB11_15:
	mov	x0, x23
	mov	x1, x20
	mov	x2, x19
	ldp	x29, x30, [sp, #192]
	ldp	x20, x19, [sp, #176]
	ldp	x22, x21, [sp, #160]
	ldp	x24, x23, [sp, #144]
	ldp	x26, x25, [sp, #128]
	add	sp, sp, #208
	ret
LBB11_16:
	ldr	w10, [x21]
	str	w10, [x23]
	ldur	w9, [x9, #-4]
	stur	w9, [x8, #-4]
	cmp	x22, #1
	b.ge	LBB11_14
	b	LBB11_15
LBB11_17:
Lloh124:
	adrp	x8, _static_string_09e773a88105e290@PAGE
Lloh125:
	add	x9, x8, _static_string_09e773a88105e290@PAGEOFF
Lloh126:
	adrp	x8, lCPI11_0@PAGE
Lloh127:
	ldr	q0, [x8, lCPI11_0@PAGEOFF]
	stur	q0, [sp, #64]
Lloh128:
	adrp	x8, _static_string_a8d4ace0dc8d360e@PAGE
Lloh129:
	add	x8, x8, _static_string_a8d4ace0dc8d360e@PAGEOFF
	str	x8, [sp, #80]
Lloh130:
	adrp	x8, lCPI11_1@PAGE
Lloh131:
	ldr	q0, [x8, lCPI11_1@PAGEOFF]
	stur	q0, [sp, #88]
Lloh132:
	adrp	x8, _static_string_7f1562353e292282@PAGE
Lloh133:
	add	x8, x8, _static_string_7f1562353e292282@PAGEOFF
	str	x8, [sp, #104]
Lloh134:
	adrp	x8, lCPI11_2@PAGE
Lloh135:
	ldr	q0, [x8, lCPI11_2@PAGEOFF]
	stur	q0, [sp, #112]
	mov	w8, #1
	stp	x8, x9, [sp, #48]
	strb	w8, [sp, #40]
	str	x8, [sp, #32]
Lloh136:
	adrp	x8, _static_string_bbe01a6a523daf15@PAGE
Lloh137:
	add	x8, x8, _static_string_bbe01a6a523daf15@PAGEOFF
	stp	xzr, x8, [sp, #16]
Lloh138:
	adrp	x8, _static_string_c44bdff4074eecdb@PAGE
Lloh139:
	add	x8, x8, _static_string_c44bdff4074eecdb@PAGEOFF
	add	x9, sp, #56
Lloh140:
	adrp	x0, _static_string_31203c1a2bdb78cc@PAGE
Lloh141:
	add	x0, x0, _static_string_31203c1a2bdb78cc@PAGEOFF
Lloh142:
	adrp	x5, _static_string_e076905c259bf94f@PAGE
Lloh143:
	add	x5, x5, _static_string_e076905c259bf94f@PAGEOFF
	add	x2, sp, #80
	add	x7, sp, #104
	stp	x9, x8, [sp]
	mov	w1, #6
	mov	w3, #232
	mov	w4, #14
	mov	w6, #54
	bl	"_std::io::io::print[KGENParamList[::Writable],*::Writable,LITImmutOrigin,::Origin[::Bool(False), $2]](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts.values`=[[typevalue<#kgen.instref<\"std::collections::string::string_slice::StringSlice,mut=0,origin._mlir_origin`={  },origin={  }\">>, struct<(pointer<none>, index)>], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::reflection::location::SourceLocation\">>, struct<(index, index, struct<(pointer<none>, index)>)>], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>]]"
	ldrb	w8, [sp, #103]
	tbz	w8, #6, LBB11_20
	ldr	x8, [sp, #80]
	sub	x0, x8, #8
	mov	x8, #-1
	ldaddal	x8, x8, [x0]
	cmp	x8, #1
	b.ne	LBB11_20
	dmb	ishld
	bl	_KGEN_CompilerRT_AlignedFree
LBB11_20:
	ldrb	w8, [sp, #127]
	tbz	w8, #6, LBB11_23
	ldr	x8, [sp, #104]
	sub	x0, x8, #8
	mov	x8, #-1
	ldaddal	x8, x8, [x0]
	cmp	x8, #1
	b.ne	LBB11_23
	dmb	ishld
	bl	_KGEN_CompilerRT_AlignedFree
LBB11_23:
	brk	#0x1
	.loh AdrpAdd	Lloh142, Lloh143
	.loh AdrpAdd	Lloh140, Lloh141
	.loh AdrpAdd	Lloh138, Lloh139
	.loh AdrpAdd	Lloh136, Lloh137
	.loh AdrpLdr	Lloh134, Lloh135
	.loh AdrpAdd	Lloh132, Lloh133
	.loh AdrpAdrp	Lloh130, Lloh132
	.loh AdrpLdr	Lloh130, Lloh131
	.loh AdrpAdd	Lloh128, Lloh129
	.loh AdrpAdrp	Lloh126, Lloh128
	.loh AdrpLdr	Lloh126, Lloh127
	.loh AdrpAdrp	Lloh124, Lloh126
	.loh AdrpAdd	Lloh124, Lloh125
	.cfi_endproc

	.p2align	2
"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]":
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!
	.cfi_def_cfa_offset 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldr	x8, [x0, #16]
	tbnz	x8, #63, LBB12_7
	ldp	x0, x9, [x0]
	add	x8, x9, x2
	cmp	x8, #2049
	b.ge	LBB12_8
LBB12_2:
	cbz	x9, LBB12_6
	add	x10, x1, x2
	cmp	x9, #4
	b.gt	LBB12_9
	sub	x11, x9, #1
	ldrb	w12, [x0]
	strb	w12, [x10]
	ldrb	w12, [x0, x11]
	strb	w12, [x10, x11]
	cmp	x9, #3
	b.lt	LBB12_6
	sub	x9, x9, #2
	ldrb	w11, [x0, #1]
	strb	w11, [x10, #1]
	ldrb	w11, [x0, x9]
	strb	w11, [x10, x9]
LBB12_6:
	mov	x0, x1
	mov	x1, x8
	ldp	x29, x30, [sp], #16
	ret
LBB12_7:
	ubfx	x9, x8, #56, #5
	add	x8, x9, x2
	cmp	x8, #2049
	b.lt	LBB12_2
LBB12_8:
	mov	w0, #1
	bl	"_std::io::io::_printf[KGENParamList[::AnyType],::StringSlice[::Bool(False), StaticConstantOrigin, *?],*::AnyType,LITImmutOrigin,::Origin[::Bool(False), $3]](*$0,file:::FileDescriptor),types.values`=[],fmt={ #interp.memref<{[(#interp.memory_handle<16, \"HEAP_BUFFER_BYTES exceeded, increase with: `mojo -D HEAP_BUFFER_BYTES=4096`\\0A\\00\" string>, const_global, [], [])], []}, 0, 0>, 76 }"
	brk	#0x1
LBB12_9:
	cmp	x9, #16
	b.gt	LBB12_12
	add	x11, x10, x9
	add	x12, x0, x9
	cmp	x9, #8
	b.lt	LBB12_18
	ldr	x9, [x0]
	str	x9, [x10]
	ldur	x9, [x12, #-8]
	stur	x9, [x11, #-8]
	mov	x0, x1
	mov	x1, x8
	ldp	x29, x30, [sp], #16
	ret
LBB12_12:
	ands	x11, x9, #0x7fffffffffffffe0
	b.eq	LBB12_15
	mov	x12, #0
LBB12_14:
	add	x13, x0, x12
	ldp	q0, q1, [x13]
	add	x13, x10, x12
	add	x12, x12, #32
	stp	q0, q1, [x13]
	cmp	x12, x11
	b.lo	LBB12_14
LBB12_15:
	subs	x9, x9, x11
	b.eq	LBB12_6
	add	x10, x2, x11
	add	x10, x1, x10
	add	x11, x0, x11
LBB12_17:
	ldrb	w12, [x11], #1
	strb	w12, [x10], #1
	subs	x9, x9, #1
	b.ne	LBB12_17
	b	LBB12_6
LBB12_18:
	ldr	w9, [x0]
	str	w9, [x10]
	ldur	w9, [x12, #-4]
	stur	w9, [x11, #-4]
	mov	x0, x1
	mov	x1, x8
	ldp	x29, x30, [sp], #16
	ret
	.cfi_endproc

	.p2align	2
"_std::ffi::__init__::_Global::_deinit_wrapper(::Optional[::UnsafePointer[::Bool(True), {}, ::NoneType, *?, ::AddressSpace(::Int(0))]]),StorageType=[typevalue<#kgen.instref<\"std::random::_rng::_RandomState\">>, struct<(struct<(struct<(simd<2, ui32>, simd<4, ui32>) memoryOnly>, simd<4, ui32>, index) memoryOnly>) memoryOnly>],name={ #interp.memref<{[(#interp.memory_handle<16, \"random_state\\00\" string>, const_global, [], [])], []}, 0, 0>, 12 },init_fn=\"std::random::_rng::_init_random_state()\",on_error_msg={ { { {:struct<()> {  }, 0} } } }":
	.cfi_startproc
	cbz	x0, LBB13_2
	b	_KGEN_CompilerRT_AlignedFree
LBB13_2:
	ret
	.cfi_endproc

	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0
lCPI14_0:
	.quad	37
	.quad	2305843009213693952
lCPI14_1:
	.quad	1
	.quad	2305843009213693952
lCPI14_2:
	.quad	2
	.quad	2305843009213693952
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	2
"_std::ffi::__init__::_Global::get_or_create_ptr(),StorageType=[typevalue<#kgen.instref<\"std::random::_rng::_RandomState\">>, struct<(struct<(struct<(simd<2, ui32>, simd<4, ui32>) memoryOnly>, simd<4, ui32>, index) memoryOnly>) memoryOnly>],name={ #interp.memref<{[(#interp.memory_handle<16, \"random_state\\00\" string>, const_global, [], [])], []}, 0, 0>, 12 },init_fn=\"std::random::_rng::_init_random_state()\",on_error_msg={ { { {:struct<()> {  }, 0} } } }_closure_0":
	.cfi_startproc
	sub	sp, sp, #144
	stp	x29, x30, [sp, #128]
	.cfi_def_cfa_offset 144
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	w0, #16
	mov	w1, #64
	bl	_KGEN_CompilerRT_AlignedAlloc
	cbz	x0, LBB14_2
	str	xzr, [x0]
	movi.2d	v0, #0000000000000000
	stp	q0, q0, [x0, #16]
	mov	w8, #4
	str	x8, [x0, #48]
	ldp	x29, x30, [sp, #128]
	add	sp, sp, #144
	ret
LBB14_2:
Lloh144:
	adrp	x8, _static_string_09e773a88105e290@PAGE
Lloh145:
	add	x9, x8, _static_string_09e773a88105e290@PAGEOFF
Lloh146:
	adrp	x8, lCPI14_0@PAGE
Lloh147:
	ldr	q0, [x8, lCPI14_0@PAGEOFF]
	stur	q0, [sp, #64]
Lloh148:
	adrp	x8, _static_string_a8d4ace0dc8d360e@PAGE
Lloh149:
	add	x8, x8, _static_string_a8d4ace0dc8d360e@PAGEOFF
	str	x8, [sp, #80]
Lloh150:
	adrp	x8, lCPI14_1@PAGE
Lloh151:
	ldr	q0, [x8, lCPI14_1@PAGEOFF]
	stur	q0, [sp, #88]
Lloh152:
	adrp	x8, _static_string_7f1562353e292282@PAGE
Lloh153:
	add	x8, x8, _static_string_7f1562353e292282@PAGEOFF
	str	x8, [sp, #104]
Lloh154:
	adrp	x8, lCPI14_2@PAGE
Lloh155:
	ldr	q0, [x8, lCPI14_2@PAGEOFF]
	stur	q0, [sp, #112]
	mov	w8, #1
	stp	x8, x9, [sp, #48]
	strb	w8, [sp, #40]
	str	x8, [sp, #32]
Lloh156:
	adrp	x8, _static_string_bbe01a6a523daf15@PAGE
Lloh157:
	add	x8, x8, _static_string_bbe01a6a523daf15@PAGEOFF
	stp	xzr, x8, [sp, #16]
Lloh158:
	adrp	x8, _static_string_c44bdff4074eecdb@PAGE
Lloh159:
	add	x8, x8, _static_string_c44bdff4074eecdb@PAGEOFF
	add	x9, sp, #56
Lloh160:
	adrp	x0, _static_string_31203c1a2bdb78cc@PAGE
Lloh161:
	add	x0, x0, _static_string_31203c1a2bdb78cc@PAGEOFF
Lloh162:
	adrp	x5, _static_string_e076905c259bf94f@PAGE
Lloh163:
	add	x5, x5, _static_string_e076905c259bf94f@PAGEOFF
	add	x2, sp, #80
	add	x7, sp, #104
	stp	x9, x8, [sp]
	mov	w1, #6
	mov	w3, #232
	mov	w4, #14
	mov	w6, #54
	bl	"_std::io::io::print[KGENParamList[::Writable],*::Writable,LITImmutOrigin,::Origin[::Bool(False), $2]](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts.values`=[[typevalue<#kgen.instref<\"std::collections::string::string_slice::StringSlice,mut=0,origin._mlir_origin`={  },origin={  }\">>, struct<(pointer<none>, index)>], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::reflection::location::SourceLocation\">>, struct<(index, index, struct<(pointer<none>, index)>)>], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>]]"
	ldrb	w8, [sp, #103]
	tbz	w8, #6, LBB14_5
	ldr	x8, [sp, #80]
	sub	x0, x8, #8
	mov	x8, #-1
	ldaddal	x8, x8, [x0]
	cmp	x8, #1
	b.ne	LBB14_5
	dmb	ishld
	bl	_KGEN_CompilerRT_AlignedFree
LBB14_5:
	ldrb	w8, [sp, #127]
	tbz	w8, #6, LBB14_8
	ldr	x8, [sp, #104]
	sub	x0, x8, #8
	mov	x8, #-1
	ldaddal	x8, x8, [x0]
	cmp	x8, #1
	b.ne	LBB14_8
	dmb	ishld
	bl	_KGEN_CompilerRT_AlignedFree
LBB14_8:
	brk	#0x1
	.loh AdrpAdd	Lloh162, Lloh163
	.loh AdrpAdd	Lloh160, Lloh161
	.loh AdrpAdd	Lloh158, Lloh159
	.loh AdrpAdd	Lloh156, Lloh157
	.loh AdrpLdr	Lloh154, Lloh155
	.loh AdrpAdd	Lloh152, Lloh153
	.loh AdrpAdrp	Lloh150, Lloh152
	.loh AdrpLdr	Lloh150, Lloh151
	.loh AdrpAdd	Lloh148, Lloh149
	.loh AdrpAdrp	Lloh146, Lloh148
	.loh AdrpLdr	Lloh146, Lloh147
	.loh AdrpAdrp	Lloh144, Lloh146
	.loh AdrpAdd	Lloh144, Lloh145
	.cfi_endproc

	.p2align	2
"_std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0":
	.cfi_startproc
	stp	x24, x23, [sp, #-64]!
	stp	x22, x21, [sp, #16]
	stp	x20, x19, [sp, #32]
	stp	x29, x30, [sp, #48]
	.cfi_def_cfa_offset 64
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	mov	x19, x2
	mov	x21, x1
	mov	x20, x0
	cmp	x2, #1, lsl #12
	b.le	LBB15_2
	ldr	x8, [x20, #4104]
	ldr	x2, [x20, #4096]
	ldr	x0, [x8]
	mov	x1, x20
	bl	_write
	str	xzr, [x20, #4096]
	ldr	x8, [x20, #4104]
	ldr	x0, [x8]
	mov	x1, x21
	mov	x2, x19
	ldp	x29, x30, [sp, #48]
	ldp	x20, x19, [sp, #32]
	ldp	x22, x21, [sp, #16]
	ldp	x24, x23, [sp], #64
	b	_write
LBB15_2:
	ldr	x2, [x20, #4096]
	add	x8, x2, x19
	cmp	x8, #1, lsl #12
	b.le	LBB15_4
	ldr	x8, [x20, #4104]
	ldr	x0, [x8]
	mov	x1, x20
	bl	_write
	mov	x2, #0
	str	xzr, [x20, #4096]
LBB15_4:
	cbz	x19, LBB15_16
	add	x8, x20, x2
	cmp	x19, #4
	b.gt	LBB15_8
	sub	x9, x19, #1
	ldrb	w10, [x21]
	strb	w10, [x8]
	ldrb	w10, [x21, x9]
	strb	w10, [x8, x9]
	cmp	x19, #3
	b.lt	LBB15_16
	sub	x9, x19, #2
	ldrb	w10, [x21, #1]
	strb	w10, [x8, #1]
	ldrb	w10, [x21, x9]
	strb	w10, [x8, x9]
	b	LBB15_16
LBB15_8:
	cmp	x19, #16
	b.gt	LBB15_11
	add	x9, x8, x19
	add	x10, x21, x19
	cmp	x19, #8
	b.lt	LBB15_15
	ldr	x11, [x21]
	str	x11, [x8]
	ldur	x8, [x10, #-8]
	stur	x8, [x9, #-8]
	b	LBB15_16
LBB15_11:
	ands	x22, x19, #0x7fffffffffffffe0
	b.eq	LBB15_13
	add	x0, x20, x2
	mov	x23, x2
	and	x2, x19, #0x7fffffffffffffe0
	mov	x1, x21
	bl	_memcpy
	mov	x2, x23
LBB15_13:
	cmp	x22, x19
	b.eq	LBB15_16
	add	x8, x20, x2
	add	x0, x8, x22
	add	x1, x21, x22
	and	x2, x19, #0x1f
	bl	_memcpy
	b	LBB15_16
LBB15_15:
	ldr	w11, [x21]
	str	w11, [x8]
	ldur	w8, [x10, #-4]
	stur	w8, [x9, #-4]
LBB15_16:
	ldr	x8, [x20, #4096]
	add	x8, x8, x19
	str	x8, [x20, #4096]
	ldp	x29, x30, [sp, #48]
	ldp	x20, x19, [sp, #32]
	ldp	x22, x21, [sp, #16]
	ldp	x24, x23, [sp], #64
	ret
	.cfi_endproc

	.p2align	2
"_std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=1":
	.cfi_startproc
	stp	x24, x23, [sp, #-64]!
	stp	x22, x21, [sp, #16]
	stp	x20, x19, [sp, #32]
	stp	x29, x30, [sp, #48]
	.cfi_def_cfa_offset 64
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	mov	x19, x2
	mov	x21, x1
	mov	x20, x0
	cmp	x2, #1, lsl #12
	b.le	LBB16_2
	ldr	x8, [x20, #4104]
	ldr	x2, [x20, #4096]
	ldr	x0, [x8]
	mov	x1, x20
	bl	_write
	str	xzr, [x20, #4096]
	ldr	x8, [x20, #4104]
	ldr	x0, [x8]
	mov	x1, x21
	mov	x2, x19
	ldp	x29, x30, [sp, #48]
	ldp	x20, x19, [sp, #32]
	ldp	x22, x21, [sp, #16]
	ldp	x24, x23, [sp], #64
	b	_write
LBB16_2:
	ldr	x2, [x20, #4096]
	add	x8, x2, x19
	cmp	x8, #1, lsl #12
	b.le	LBB16_4
	ldr	x8, [x20, #4104]
	ldr	x0, [x8]
	mov	x1, x20
	bl	_write
	mov	x2, #0
	str	xzr, [x20, #4096]
LBB16_4:
	cbz	x19, LBB16_16
	add	x8, x20, x2
	cmp	x19, #4
	b.gt	LBB16_8
	sub	x9, x19, #1
	ldrb	w10, [x21]
	strb	w10, [x8]
	ldrb	w10, [x21, x9]
	strb	w10, [x8, x9]
	cmp	x19, #3
	b.lt	LBB16_16
	sub	x9, x19, #2
	ldrb	w10, [x21, #1]
	strb	w10, [x8, #1]
	ldrb	w10, [x21, x9]
	strb	w10, [x8, x9]
	b	LBB16_16
LBB16_8:
	cmp	x19, #16
	b.gt	LBB16_11
	add	x9, x8, x19
	add	x10, x21, x19
	cmp	x19, #8
	b.lt	LBB16_15
	ldr	x11, [x21]
	str	x11, [x8]
	ldur	x8, [x10, #-8]
	stur	x8, [x9, #-8]
	b	LBB16_16
LBB16_11:
	ands	x22, x19, #0x7fffffffffffffe0
	b.eq	LBB16_13
	add	x0, x20, x2
	mov	x23, x2
	and	x2, x19, #0x7fffffffffffffe0
	mov	x1, x21
	bl	_memcpy
	mov	x2, x23
LBB16_13:
	cmp	x22, x19
	b.eq	LBB16_16
	add	x8, x20, x2
	add	x0, x8, x22
	add	x1, x21, x22
	and	x2, x19, #0x1f
	bl	_memcpy
	b	LBB16_16
LBB16_15:
	ldr	w11, [x21]
	str	w11, [x8]
	ldur	w8, [x10, #-4]
	stur	w8, [x9, #-4]
LBB16_16:
	ldr	x8, [x20, #4096]
	add	x8, x8, x19
	str	x8, [x20, #4096]
	ldp	x29, x30, [sp, #48]
	ldp	x20, x19, [sp, #32]
	ldp	x22, x21, [sp, #16]
	ldp	x24, x23, [sp], #64
	ret
	.cfi_endproc

	.section	__TEXT,__literal8,8byte_literals
	.p2align	3, 0x0
lCPI17_0:
	.long	2654435769
	.long	3144134277
lCPI17_1:
	.long	1013904242
	.long	1993301258
lCPI17_2:
	.long	3668340011
	.long	842468239
lCPI17_3:
	.long	2027808484
	.long	3986602516
lCPI17_4:
	.long	387276957
	.long	2835769497
lCPI17_5:
	.long	3041712726
	.long	1684936478
lCPI17_6:
	.long	1401181199
	.long	534103459
lCPI17_7:
	.long	4055616968
	.long	3678237736
lCPI17_8:
	.long	2415085441
	.long	2527404717
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	2
"_std::random::_rng::_PhiloxWrapper::next_uint32(::_PhiloxWrapper&)":
	ldr	x9, [sp]
	cmp	x9, #4
	b.lt	LBB17_5
	fmov	w10, s1
	mov	w13, #8019
	movk	w13, #53841, lsl #16
	umull	x9, w10, w13
	fmov	d2, x9
	mov.s	w9, v1[2]
	mov	w14, #36183
	movk	w14, #52638, lsl #16
	umull	x11, w9, w14
	fmov	d3, x11
	mov.s	w12, v1[1]
	dup.2s	v4, v3[1]
	eor.8b	v4, v0, v4
	fmov	w11, s4
	eor	w15, w11, w12
	mov.s	w11, v1[3]
	eor.8b	v4, v0, v2
	mov.s	w16, v4[1]
	eor	w16, w16, w11
Lloh164:
	adrp	x17, lCPI17_0@PAGE
Lloh165:
	ldr	d4, [x17, lCPI17_0@PAGEOFF]
	add.2s	v4, v0, v4
	umull	x15, w15, w13
	fmov	d5, x15
	umull	x15, w16, w14
	fmov	d6, x15
	dup.2s	v7, v6[1]
	eor3.16b	v3, v7, v3, v4
	fmov	w15, s3
	eor.8b	v3, v4, v5
	dup.2s	v3, v3[1]
	eor.8b	v2, v3, v2
	fmov	w16, s2
Lloh166:
	adrp	x17, lCPI17_1@PAGE
Lloh167:
	ldr	d2, [x17, lCPI17_1@PAGEOFF]
	add.2s	v2, v0, v2
	umull	x15, w15, w13
	fmov	d3, x15
	umull	x15, w16, w14
	fmov	d4, x15
	dup.2s	v7, v4[1]
	eor3.16b	v6, v7, v6, v2
	fmov	w15, s6
	eor.8b	v2, v2, v3
	dup.2s	v2, v2[1]
	eor.8b	v2, v2, v5
	fmov	w16, s2
Lloh168:
	adrp	x17, lCPI17_2@PAGE
Lloh169:
	ldr	d2, [x17, lCPI17_2@PAGEOFF]
	add.2s	v2, v0, v2
	umull	x15, w15, w13
	fmov	d5, x15
	umull	x15, w16, w14
	fmov	d6, x15
	dup.2s	v7, v6[1]
	eor3.16b	v4, v7, v4, v2
	eor.8b	v2, v2, v5
	dup.2s	v2, v2[1]
	fmov	w15, s4
	eor.8b	v2, v2, v3
	fmov	w16, s2
Lloh170:
	adrp	x17, lCPI17_3@PAGE
Lloh171:
	ldr	d2, [x17, lCPI17_3@PAGEOFF]
	add.2s	v2, v0, v2
	umull	x15, w15, w13
	fmov	d3, x15
	umull	x15, w16, w14
	fmov	d4, x15
	dup.2s	v7, v4[1]
	eor3.16b	v6, v7, v6, v2
	fmov	w15, s6
	eor.8b	v2, v2, v3
	dup.2s	v2, v2[1]
	eor.8b	v2, v2, v5
	fmov	w16, s2
Lloh172:
	adrp	x17, lCPI17_4@PAGE
Lloh173:
	ldr	d2, [x17, lCPI17_4@PAGEOFF]
	add.2s	v2, v0, v2
	umull	x15, w15, w13
	fmov	d5, x15
	umull	x15, w16, w14
	fmov	d6, x15
	dup.2s	v7, v6[1]
	eor3.16b	v4, v7, v4, v2
	fmov	w15, s4
	eor.8b	v2, v2, v5
	dup.2s	v2, v2[1]
	eor.8b	v2, v2, v3
	fmov	w16, s2
Lloh174:
	adrp	x17, lCPI17_5@PAGE
Lloh175:
	ldr	d2, [x17, lCPI17_5@PAGEOFF]
	add.2s	v2, v0, v2
	umull	x15, w15, w13
	fmov	d3, x15
	umull	x15, w16, w14
	fmov	d4, x15
	dup.2s	v7, v4[1]
	eor3.16b	v6, v7, v6, v2
	eor.8b	v2, v2, v3
	dup.2s	v2, v2[1]
	fmov	w15, s6
	eor.8b	v2, v2, v5
	fmov	w16, s2
Lloh176:
	adrp	x17, lCPI17_6@PAGE
Lloh177:
	ldr	d2, [x17, lCPI17_6@PAGEOFF]
	add.2s	v2, v0, v2
	umull	x15, w15, w13
	fmov	d5, x15
	umull	x15, w16, w14
	fmov	d6, x15
	dup.2s	v7, v6[1]
	eor3.16b	v4, v7, v4, v2
	fmov	w15, s4
	eor.8b	v2, v2, v5
	dup.2s	v2, v2[1]
	eor.8b	v2, v2, v3
	fmov	w16, s2
Lloh178:
	adrp	x17, lCPI17_7@PAGE
Lloh179:
	ldr	d2, [x17, lCPI17_7@PAGEOFF]
	add.2s	v2, v0, v2
	umull	x15, w15, w13
	fmov	d3, x15
	umull	x15, w16, w14
	fmov	d4, x15
	dup.2s	v7, v4[1]
	eor3.16b	v6, v7, v6, v2
	fmov	w15, s6
	eor.8b	v2, v2, v3
	dup.2s	v2, v2[1]
	eor.8b	v2, v2, v5
	fmov	w16, s2
Lloh180:
	adrp	x17, lCPI17_8@PAGE
Lloh181:
	ldr	d2, [x17, lCPI17_8@PAGEOFF]
	add.2s	v2, v0, v2
	umull	x13, w15, w13
	fmov	d5, x13
	umull	x13, w16, w14
	fmov	d6, x13
	eor.8b	v7, v2, v5
	dup.2s	v7, v7[1]
	eor.8b	v3, v7, v3
	dup.2s	v7, v6[1]
	eor3.16b	v2, v2, v4, v7
	zip1.2s	v2, v2, v6
	mov.d	v2[1], v3[0]
	mov.s	v2[3], v5[0]
	adds	w10, w10, #1
	mov.s	v1[0], w10
	adcs	w10, w12, wzr
	mov.s	v1[1], w10
	b.lo	LBB17_4
	adds	w9, w9, #1
	mov.s	v1[2], w9
	mov	x9, #0
	b.lo	LBB17_5
	add	w10, w11, #1
	mov.s	v1[3], w10
	b	LBB17_5
LBB17_4:
	mov	x9, #0
LBB17_5:
	and	x10, x9, #0x3
	mov	x11, x8
	str	q2, [x11, #48]!
	ldr	w10, [x11, x10, lsl #2]
	add	x9, x9, #1
	str	q1, [x8, #32]
	str	d0, [x8, #16]
	str	x9, [x8, #64]
	str	w10, [x8]
	ret
	.loh AdrpLdr	Lloh180, Lloh181
	.loh AdrpAdrp	Lloh178, Lloh180
	.loh AdrpLdr	Lloh178, Lloh179
	.loh AdrpAdrp	Lloh176, Lloh178
	.loh AdrpLdr	Lloh176, Lloh177
	.loh AdrpAdrp	Lloh174, Lloh176
	.loh AdrpLdr	Lloh174, Lloh175
	.loh AdrpAdrp	Lloh172, Lloh174
	.loh AdrpLdr	Lloh172, Lloh173
	.loh AdrpAdrp	Lloh170, Lloh172
	.loh AdrpLdr	Lloh170, Lloh171
	.loh AdrpAdrp	Lloh168, Lloh170
	.loh AdrpLdr	Lloh168, Lloh169
	.loh AdrpAdrp	Lloh166, Lloh168
	.loh AdrpLdr	Lloh166, Lloh167
	.loh AdrpAdrp	Lloh164, Lloh166
	.loh AdrpLdr	Lloh164, Lloh165

	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0
lCPI18_0:
	.quad	6
	.quad	2305843009213693952
lCPI18_1:
	.quad	39
	.quad	2305843009213693952
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	2
"_std::builtin::_format_float::_compute_endpoint[::DType,::Int,::Int,::Int](::Int,::Int,::Bool),CarrierDType=ui64,sig_bits=52,total_bits=64,cache_bits=128":
	.cfi_startproc
	stp	x20, x19, [sp, #-32]!
	stp	x29, x30, [sp, #16]
	sub	sp, sp, #2096
	.cfi_def_cfa_offset 2128
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
Lloh182:
	adrp	x8, _static_string_ffe5c571af8dd3fc@PAGE
Lloh183:
	add	x8, x8, _static_string_ffe5c571af8dd3fc@PAGEOFF
	str	x8, [sp]
Lloh184:
	adrp	x8, lCPI18_0@PAGE
Lloh185:
	ldr	q0, [x8, lCPI18_0@PAGEOFF]
Lloh186:
	adrp	x8, _static_string_a0fcf35b7349c924@PAGE
Lloh187:
	add	x8, x8, _static_string_a0fcf35b7349c924@PAGEOFF
	stur	q0, [sp, #8]
	str	x8, [sp, #24]
Lloh188:
	adrp	x8, lCPI18_1@PAGE
Lloh189:
	ldr	q0, [x8, lCPI18_1@PAGEOFF]
	stur	q0, [sp, #32]
	cmp	x0, #619
	b.hs	LBB18_2
	mov	w8, #11
	sub	x8, x8, x1
Lloh190:
	adrp	x9, _global_constant@PAGE
Lloh191:
	add	x9, x9, _global_constant@PAGEOFF
	add	x9, x9, x0, lsl #4
	ldr	x9, [x9, #8]
	lsr	x10, x9, #53
	lsr	x11, x9, #54
	tst	w2, #0x1
	csneg	x10, x10, x11, eq
	add	x9, x10, x9
	lsr	x0, x9, x8
	add	sp, sp, #2096
	ldp	x29, x30, [sp, #16]
	ldp	x20, x19, [sp], #32
	ret
LBB18_2:
	mov	x19, x0
	mov	x0, sp
	add	x1, sp, #48
	mov	x2, #0
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	mov	x0, x19
	mov	x1, x2
	mov	x2, x3
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	add	x0, sp, #24
	mov	x1, x2
	mov	x2, x3
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	mov	w0, #618
	mov	x1, x2
	mov	x2, x3
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	add	x8, x1, #1
	cmp	x8, #2049
	b.lt	LBB18_4
	mov	w0, #1
	bl	"_std::io::io::_printf[KGENParamList[::AnyType],::StringSlice[::Bool(False), StaticConstantOrigin, *?],*::AnyType,LITImmutOrigin,::Origin[::Bool(False), $3]](*$0,file:::FileDescriptor),types.values`=[],fmt={ #interp.memref<{[(#interp.memory_handle<16, \"HEAP_BUFFER_BYTES exceeded, increase with: `mojo -D HEAP_BUFFER_BYTES=4096`\\0A\\00\" string>, const_global, [], [])], []}, 0, 0>, 76 }"
	brk	#0x1
LBB18_4:
	strb	wzr, [x0, x1]
Lloh192:
	adrp	x3, _static_string_cfa776fe0f373673@PAGE
Lloh193:
	add	x3, x3, _static_string_cfa776fe0f373673@PAGEOFF
	mov	w1, #477
	mov	w2, #49
	mov	w4, #54
	bl	"_std::builtin::debug_assert::_debug_assert_msg[LITImmutOrigin,::Origin[::Bool(False), $0]](::UnsafePointer[::Bool(False), $0, ::SIMD[::DType(uint8), ::Int(1)], $1, ::AddressSpace(::Int(0))],::Int,::SourceLocation)"
	.loh AdrpLdr	Lloh188, Lloh189
	.loh AdrpAdd	Lloh186, Lloh187
	.loh AdrpAdrp	Lloh184, Lloh186
	.loh AdrpLdr	Lloh184, Lloh185
	.loh AdrpAdd	Lloh182, Lloh183
	.loh AdrpAdd	Lloh190, Lloh191
	.loh AdrpAdd	Lloh192, Lloh193
	.cfi_endproc

	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0
lCPI19_0:
	.quad	6
	.quad	2305843009213693952
lCPI19_1:
	.quad	39
	.quad	2305843009213693952
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	2
"_std::builtin::_format_float::_compute_mul_parity[::DType](::SIMD[$0, ::Int(1)],::Int,::Int),CarrierDType=ui64":
	.cfi_startproc
	stp	x20, x19, [sp, #-32]!
	stp	x29, x30, [sp, #16]
	sub	sp, sp, #2096
	.cfi_def_cfa_offset 2128
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
Lloh194:
	adrp	x8, _static_string_ffe5c571af8dd3fc@PAGE
Lloh195:
	add	x8, x8, _static_string_ffe5c571af8dd3fc@PAGEOFF
	str	x8, [sp]
Lloh196:
	adrp	x8, lCPI19_0@PAGE
Lloh197:
	ldr	q0, [x8, lCPI19_0@PAGEOFF]
Lloh198:
	adrp	x8, _static_string_a0fcf35b7349c924@PAGE
Lloh199:
	add	x8, x8, _static_string_a0fcf35b7349c924@PAGEOFF
	stur	q0, [sp, #8]
	str	x8, [sp, #24]
Lloh200:
	adrp	x8, lCPI19_1@PAGE
Lloh201:
	ldr	q0, [x8, lCPI19_1@PAGEOFF]
	stur	q0, [sp, #32]
	cmp	x1, #619
	b.hs	LBB19_2
Lloh202:
	adrp	x8, _global_constant@PAGE
Lloh203:
	add	x8, x8, _global_constant@PAGEOFF
	add	x8, x8, x1, lsl #4
	ldp	x9, x8, [x8]
	mul	x8, x0, x8
	lsr	x10, x0, #32
	lsr	x11, x9, #32
	mov	w12, w0
	umull	x12, w11, w12
	mov	w13, w9
	umull	x13, w13, w10
	umull	x9, w9, w0
	lsr	x14, x9, #32
	add	x14, x14, w13, uxtw
	add	x14, x14, w12, uxtw
	and	x9, x9, #0xfffffffe
	orr	x9, x9, x14, lsl #32
	umaddl	x8, w11, w10, x8
	add	x8, x8, x13, lsr #32
	add	x8, x8, x12, lsr #32
	add	x8, x8, x14, lsr #32
	neg	x10, x2
	lsr	x10, x8, x10
	lsl	x8, x8, x2
	lsr	x9, x9, #1
	mvn	w11, w2
	lsr	x9, x9, x11
	orr	x8, x8, x9
	cmp	x8, #0
	cset	w1, eq
	and	w0, w10, #0x1
	add	sp, sp, #2096
	ldp	x29, x30, [sp, #16]
	ldp	x20, x19, [sp], #32
	ret
LBB19_2:
	mov	x0, sp
	mov	x19, x1
	add	x1, sp, #48
	mov	x2, #0
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	mov	x0, x19
	mov	x1, x2
	mov	x2, x3
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	add	x0, sp, #24
	mov	x1, x2
	mov	x2, x3
	bl	"_std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	mov	x2, x0
	mov	x3, x1
	mov	w0, #618
	mov	x1, x2
	mov	x2, x3
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	add	x8, x1, #1
	cmp	x8, #2049
	b.lt	LBB19_4
	mov	w0, #1
	bl	"_std::io::io::_printf[KGENParamList[::AnyType],::StringSlice[::Bool(False), StaticConstantOrigin, *?],*::AnyType,LITImmutOrigin,::Origin[::Bool(False), $3]](*$0,file:::FileDescriptor),types.values`=[],fmt={ #interp.memref<{[(#interp.memory_handle<16, \"HEAP_BUFFER_BYTES exceeded, increase with: `mojo -D HEAP_BUFFER_BYTES=4096`\\0A\\00\" string>, const_global, [], [])], []}, 0, 0>, 76 }"
	brk	#0x1
LBB19_4:
	strb	wzr, [x0, x1]
Lloh204:
	adrp	x3, _static_string_cfa776fe0f373673@PAGE
Lloh205:
	add	x3, x3, _static_string_cfa776fe0f373673@PAGEOFF
	mov	w1, #689
	mov	w2, #41
	mov	w4, #54
	bl	"_std::builtin::debug_assert::_debug_assert_msg[LITImmutOrigin,::Origin[::Bool(False), $0]](::UnsafePointer[::Bool(False), $0, ::SIMD[::DType(uint8), ::Int(1)], $1, ::AddressSpace(::Int(0))],::Int,::SourceLocation)"
	.loh AdrpLdr	Lloh200, Lloh201
	.loh AdrpAdd	Lloh198, Lloh199
	.loh AdrpAdrp	Lloh196, Lloh198
	.loh AdrpLdr	Lloh196, Lloh197
	.loh AdrpAdd	Lloh194, Lloh195
	.loh AdrpAdd	Lloh202, Lloh203
	.loh AdrpAdd	Lloh204, Lloh205
	.cfi_endproc

	.p2align	2
"_std::builtin::debug_assert::_debug_assert_msg[LITImmutOrigin,::Origin[::Bool(False), $0]](::UnsafePointer[::Bool(False), $0, ::SIMD[::DType(uint8), ::Int(1)], $1, ::AddressSpace(::Int(0))],::Int,::SourceLocation)":
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!
	.cfi_def_cfa_offset 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	x8, x0
	mov	x0, x3
	mov	x3, x8
	mov	w4, #1
	bl	"_std::io::io::_printf[KGENParamList[::AnyType],::StringSlice[::Bool(False), StaticConstantOrigin, *?],*::AnyType,LITImmutOrigin,::Origin[::Bool(False), $3]](*$0,file:::FileDescriptor),types.values`=[[typevalue<#kgen.instref<\"std::memory::unsafe_pointer::UnsafePointer,mut=0,origin._mlir_origin`={  },type=[typevalue<#kgen.instref<\\1B\\22std::builtin::simd::SIMD,dtype=ui8,size=1\\22>>, scalar<ui8>],origin={  },address_space=0\">>, pointer<none>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::memory::unsafe_pointer::UnsafePointer,mut=0,origin._mlir_origin`={  },type=[typevalue<#kgen.instref<\\1B\\22std::builtin::simd::SIMD,dtype=ui8,size=1\\22>>, scalar<ui8>],origin={  },address_space=0\">>, pointer<none>]],fmt={ #interp.memref<{[(#interp.memory_handle<16, \"At: %s:%llu:%llu: Assert Error: %s\\0A\\00\" string>, const_global, [], [])], []}, 0, 0>, 35 }"
	brk	#0x1
	.cfi_endproc

	.p2align	2
"_std::io::io::_flush(::FileDescriptor)":
	.cfi_startproc
	stp	x20, x19, [sp, #-32]!
	stp	x29, x30, [sp, #16]
	.cfi_def_cfa_offset 32
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	bl	_dup
Lloh206:
	adrp	x1, _static_string_0d78baac08237ddb@PAGE
Lloh207:
	add	x1, x1, _static_string_0d78baac08237ddb@PAGEOFF
	bl	_fdopen
	mov	x19, x0
	bl	_fflush
	mov	x0, x19
	ldp	x29, x30, [sp, #16]
	ldp	x20, x19, [sp], #32
	b	_fclose
	.loh AdrpAdd	Lloh206, Lloh207
	.cfi_endproc

	.p2align	2
"_std::io::io::_printf[KGENParamList[::AnyType],::StringSlice[::Bool(False), StaticConstantOrigin, *?],*::AnyType,LITImmutOrigin,::Origin[::Bool(False), $3]](*$0,file:::FileDescriptor),types.values`=[],fmt={ #interp.memref<{[(#interp.memory_handle<16, \"HEAP_BUFFER_BYTES exceeded, increase with: `mojo -D HEAP_BUFFER_BYTES=4096`\\0A\\00\" string>, const_global, [], [])], []}, 0, 0>, 76 }":
	.cfi_startproc
	stp	x20, x19, [sp, #-32]!
	stp	x29, x30, [sp, #16]
	.cfi_def_cfa_offset 32
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	bl	_dup
Lloh208:
	adrp	x1, _static_string_0d78baac08237ddb@PAGE
Lloh209:
	add	x1, x1, _static_string_0d78baac08237ddb@PAGEOFF
	bl	_fdopen
	mov	x19, x0
Lloh210:
	adrp	x1, _static_string_98e090712d66312f@PAGE
Lloh211:
	add	x1, x1, _static_string_98e090712d66312f@PAGEOFF
	bl	_KGEN_CompilerRT_fprintf
	mov	x0, x19
	ldp	x29, x30, [sp, #16]
	ldp	x20, x19, [sp], #32
	b	_fclose
	.loh AdrpAdd	Lloh210, Lloh211
	.loh AdrpAdd	Lloh208, Lloh209
	.cfi_endproc

	.p2align	2
"_std::io::io::_printf[KGENParamList[::AnyType],::StringSlice[::Bool(False), StaticConstantOrigin, *?],*::AnyType,LITImmutOrigin,::Origin[::Bool(False), $3]](*$0,file:::FileDescriptor),types.values`=[[typevalue<#kgen.instref<\"std::memory::unsafe_pointer::UnsafePointer,mut=0,origin._mlir_origin`={  },type=[typevalue<#kgen.instref<\\1B\\22std::builtin::simd::SIMD,dtype=ui8,size=1\\22>>, scalar<ui8>],origin={  },address_space=0\">>, pointer<none>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::memory::unsafe_pointer::UnsafePointer,mut=0,origin._mlir_origin`={  },type=[typevalue<#kgen.instref<\\1B\\22std::builtin::simd::SIMD,dtype=ui8,size=1\\22>>, scalar<ui8>],origin={  },address_space=0\">>, pointer<none>]],fmt={ #interp.memref<{[(#interp.memory_handle<16, \"At: %s:%llu:%llu: Assert Error: %s\\0A\\00\" string>, const_global, [], [])], []}, 0, 0>, 35 }":
	.cfi_startproc
	sub	sp, sp, #96
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	.cfi_def_cfa_offset 96
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	mov	x19, x3
	mov	x20, x2
	mov	x21, x1
	mov	x22, x0
	mov	x0, x4
	bl	_dup
Lloh212:
	adrp	x1, _static_string_0d78baac08237ddb@PAGE
Lloh213:
	add	x1, x1, _static_string_0d78baac08237ddb@PAGEOFF
	bl	_fdopen
	mov	x23, x0
	stp	x20, x19, [sp, #16]
	stp	x22, x21, [sp]
Lloh214:
	adrp	x1, _static_string_0dcb71a55f79a509@PAGE
Lloh215:
	add	x1, x1, _static_string_0dcb71a55f79a509@PAGEOFF
	bl	_KGEN_CompilerRT_fprintf
	mov	x0, x23
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	add	sp, sp, #96
	b	_fclose
	.loh AdrpAdd	Lloh214, Lloh215
	.loh AdrpAdd	Lloh212, Lloh213
	.cfi_endproc

	.p2align	2
"_std::io::io::print[KGENParamList[::Writable],*::Writable,LITImmutOrigin,::Origin[::Bool(False), $2]](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts.values`=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index]]":
	.cfi_startproc
	stp	x28, x27, [sp, #-80]!
	stp	x24, x23, [sp, #16]
	stp	x22, x21, [sp, #32]
	stp	x20, x19, [sp, #48]
	stp	x29, x30, [sp, #64]
	sub	sp, sp, #1, lsl #12
	sub	sp, sp, #32
	.cfi_def_cfa_offset 4208
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w27, -72
	.cfi_offset w28, -80
	mov	x19, x6
	mov	x20, x5
	mov	x21, x4
	mov	x23, x3
	mov	x24, x2
	mov	x22, x1
	mov	x1, x0
	str	x7, [sp, #8]
	str	xzr, [sp, #4112]
	add	x8, sp, #8
	str	x8, [sp, #4120]
	ldr	x8, [x0, #16]
	tbnz	x8, #63, LBB24_2
	ldp	x1, x2, [x1]
	b	LBB24_3
LBB24_2:
	ubfx	x2, x8, #56, #5
LBB24_3:
	add	x0, sp, #16
	bl	"_std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"
	add	x0, sp, #16
	mov	x1, x24
	mov	x2, x23
	bl	"_std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"
	add	x1, sp, #16
	mov	x0, x22
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"
	add	x0, sp, #16
	mov	x1, x21
	mov	x2, x20
	bl	"_std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"
	ldr	x8, [sp, #4120]
	ldr	x2, [sp, #4112]
	ldr	x0, [x8]
	add	x1, sp, #16
	bl	_write
	tbz	w19, #0, LBB24_5
	ldr	x0, [sp, #8]
	add	sp, sp, #1, lsl #12
	add	sp, sp, #32
	ldp	x29, x30, [sp, #64]
	ldp	x20, x19, [sp, #48]
	ldp	x22, x21, [sp, #32]
	ldp	x24, x23, [sp, #16]
	ldp	x28, x27, [sp], #80
	b	"_std::io::io::_flush(::FileDescriptor)"
LBB24_5:
	add	sp, sp, #1, lsl #12
	add	sp, sp, #32
	ldp	x29, x30, [sp, #64]
	ldp	x20, x19, [sp, #48]
	ldp	x22, x21, [sp, #32]
	ldp	x24, x23, [sp, #16]
	ldp	x28, x27, [sp], #80
	ret
	.cfi_endproc

	.p2align	2
"_std::io::io::print[KGENParamList[::Writable],*::Writable,LITImmutOrigin,::Origin[::Bool(False), $2]](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts.values`=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::simd::SIMD,dtype=f64,size=1\">>, scalar<f64>]]":
	.cfi_startproc
	stp	d9, d8, [sp, #-80]!
	stp	x24, x23, [sp, #16]
	stp	x22, x21, [sp, #32]
	stp	x20, x19, [sp, #48]
	stp	x29, x30, [sp, #64]
	sub	sp, sp, #1, lsl #12
	sub	sp, sp, #32
	.cfi_def_cfa_offset 4208
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset b8, -72
	.cfi_offset b9, -80
	mov	x19, x5
	mov	x20, x4
	mov	x21, x3
	mov	x22, x2
	mov	x23, x1
	mov.16b	v8, v0
	mov	x1, x0
	str	x6, [sp, #8]
	str	xzr, [sp, #4112]
	add	x8, sp, #8
	str	x8, [sp, #4120]
	ldr	x8, [x0, #16]
	tbnz	x8, #63, LBB25_2
	ldp	x1, x2, [x1]
	b	LBB25_3
LBB25_2:
	ubfx	x2, x8, #56, #5
LBB25_3:
	add	x0, sp, #16
	bl	"_std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"
	add	x0, sp, #16
	mov	x1, x23
	mov	x2, x22
	bl	"_std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"
	add	x0, sp, #16
	mov.16b	v0, v8
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=f64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"
	add	x0, sp, #16
	mov	x1, x21
	mov	x2, x20
	bl	"_std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"
	ldr	x8, [sp, #4120]
	ldr	x2, [sp, #4112]
	ldr	x0, [x8]
	add	x1, sp, #16
	bl	_write
	tbz	w19, #0, LBB25_5
	ldr	x0, [sp, #8]
	add	sp, sp, #1, lsl #12
	add	sp, sp, #32
	ldp	x29, x30, [sp, #64]
	ldp	x20, x19, [sp, #48]
	ldp	x22, x21, [sp, #32]
	ldp	x24, x23, [sp, #16]
	ldp	d9, d8, [sp], #80
	b	"_std::io::io::_flush(::FileDescriptor)"
LBB25_5:
	add	sp, sp, #1, lsl #12
	add	sp, sp, #32
	ldp	x29, x30, [sp, #64]
	ldp	x20, x19, [sp, #48]
	ldp	x22, x21, [sp, #32]
	ldp	x24, x23, [sp, #16]
	ldp	d9, d8, [sp], #80
	ret
	.cfi_endproc

	.p2align	2
"_std::io::io::print[KGENParamList[::Writable],*::Writable,LITImmutOrigin,::Origin[::Bool(False), $2]](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts.values`=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::simd::SIMD,dtype=uindex,size=1\">>, scalar<uindex>]]":
	.cfi_startproc
	stp	x28, x27, [sp, #-80]!
	stp	x24, x23, [sp, #16]
	stp	x22, x21, [sp, #32]
	stp	x20, x19, [sp, #48]
	stp	x29, x30, [sp, #64]
	sub	sp, sp, #1, lsl #12
	sub	sp, sp, #32
	.cfi_def_cfa_offset 4208
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w27, -72
	.cfi_offset w28, -80
	mov	x19, x6
	mov	x20, x5
	mov	x21, x4
	mov	x23, x3
	mov	x24, x2
	mov	x22, x1
	mov	x1, x0
	str	x7, [sp, #8]
	str	xzr, [sp, #4112]
	add	x8, sp, #8
	str	x8, [sp, #4120]
	ldr	x8, [x0, #16]
	tbnz	x8, #63, LBB26_2
	ldp	x1, x2, [x1]
	b	LBB26_3
LBB26_2:
	ubfx	x2, x8, #56, #5
LBB26_3:
	add	x0, sp, #16
	bl	"_std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"
	add	x0, sp, #16
	mov	x1, x24
	mov	x2, x23
	bl	"_std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"
	add	x1, sp, #16
	mov	x0, x22
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=uindex,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"
	add	x0, sp, #16
	mov	x1, x21
	mov	x2, x20
	bl	"_std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"
	ldr	x8, [sp, #4120]
	ldr	x2, [sp, #4112]
	ldr	x0, [x8]
	add	x1, sp, #16
	bl	_write
	tbz	w19, #0, LBB26_5
	ldr	x0, [sp, #8]
	add	sp, sp, #1, lsl #12
	add	sp, sp, #32
	ldp	x29, x30, [sp, #64]
	ldp	x20, x19, [sp, #48]
	ldp	x22, x21, [sp, #32]
	ldp	x24, x23, [sp, #16]
	ldp	x28, x27, [sp], #80
	b	"_std::io::io::_flush(::FileDescriptor)"
LBB26_5:
	add	sp, sp, #1, lsl #12
	add	sp, sp, #32
	ldp	x29, x30, [sp, #64]
	ldp	x20, x19, [sp, #48]
	ldp	x22, x21, [sp, #32]
	ldp	x24, x23, [sp, #16]
	ldp	x28, x27, [sp], #80
	ret
	.cfi_endproc

	.p2align	2
"_std::io::io::print[KGENParamList[::Writable],*::Writable,LITImmutOrigin,::Origin[::Bool(False), $2]](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts.values`=[[typevalue<#kgen.instref<\"std::collections::string::string_slice::StringSlice,mut=0,origin._mlir_origin`={  },origin={  }\">>, struct<(pointer<none>, index)>], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::reflection::location::SourceLocation\">>, struct<(index, index, struct<(pointer<none>, index)>)>], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>]]":
	.cfi_startproc
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	sub	sp, sp, #1, lsl #12
	sub	sp, sp, #64
	.cfi_def_cfa_offset 4256
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	.cfi_offset w27, -88
	.cfi_offset w28, -96
	mov	x22, x7
	mov	x27, x6
	mov	x28, x5
	mov	x25, x4
	mov	x26, x3
	mov	x19, x2
	mov	x2, x1
	mov	x1, x0
	ldr	x9, [sp, #4288]
	ldr	x8, [sp, #4280]
	stp	x8, x9, [sp, #16]
	ldr	x23, [sp, #4272]
	add	x8, sp, #201
	ldrb	w8, [x8, #4095]
	str	w8, [sp, #36]
	ldr	x24, [sp, #4264]
	ldr	x21, [sp, #4256]
	ldr	x8, [sp, #4304]
	str	x8, [sp, #40]
	str	xzr, [sp, #4144]
	add	x8, sp, #40
	str	x8, [sp, #4152]
	add	x0, sp, #48
	bl	"_std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"
	add	x0, sp, #48
	mov	x1, x24
	mov	x2, x23
	bl	"_std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"
	ldr	x8, [x19, #16]
	tbnz	x8, #63, LBB27_2
	ldp	x19, x2, [x19]
	b	LBB27_3
LBB27_2:
	ubfx	x2, x8, #56, #5
LBB27_3:
	add	x20, sp, #48
	add	x0, sp, #48
	mov	x1, x19
	bl	"_std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"
	add	x0, sp, #48
	mov	x1, x24
	mov	x2, x23
	bl	"_std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"
	add	x0, sp, #48
	mov	x1, x28
	mov	x2, x27
	bl	"_std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"
	ldr	x2, [sp, #4144]
	add	x8, x2, #1
	cmp	x8, #1, lsl #12
	b.le	LBB27_5
	ldr	x8, [sp, #4152]
	ldr	x0, [x8]
	add	x1, sp, #48
	bl	_write
	mov	x2, #0
	str	xzr, [sp, #4144]
LBB27_5:
	mov	w19, #58
	strb	w19, [x20, x2]
	ldr	x8, [sp, #4144]
	add	x8, x8, #1
	str	x8, [sp, #4144]
	add	x1, sp, #48
	mov	x0, x26
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"
	ldr	x2, [sp, #4144]
	add	x8, x2, #1
	cmp	x8, #1, lsl #12
	b.le	LBB27_7
	ldr	x8, [sp, #4152]
	ldr	x0, [x8]
	add	x1, sp, #48
	bl	_write
	mov	x2, #0
	str	xzr, [sp, #4144]
LBB27_7:
	add	x8, sp, #48
	strb	w19, [x8, x2]
	ldr	x8, [sp, #4144]
	add	x8, x8, #1
	str	x8, [sp, #4144]
	add	x1, sp, #48
	mov	x0, x25
	bl	"_std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"
	add	x0, sp, #48
	mov	x1, x24
	mov	x2, x23
	bl	"_std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"
	ldr	x8, [x22, #16]
	tbnz	x8, #63, LBB27_9
	ldp	x22, x2, [x22]
	b	LBB27_10
LBB27_9:
	ubfx	x2, x8, #56, #5
LBB27_10:
	add	x0, sp, #48
	mov	x1, x22
	bl	"_std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"
	add	x0, sp, #48
	mov	x1, x24
	mov	x2, x23
	bl	"_std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"
	ldr	x8, [x21, #16]
	tbnz	x8, #63, LBB27_12
	ldp	x21, x2, [x21]
	b	LBB27_13
LBB27_12:
	ubfx	x2, x8, #56, #5
LBB27_13:
	add	x0, sp, #48
	mov	x1, x21
	bl	"_std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"
	add	x0, sp, #48
	ldp	x1, x2, [sp, #16]
	bl	"_std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"
	ldr	x8, [sp, #4152]
	ldr	x2, [sp, #4144]
	ldr	x0, [x8]
	add	x1, sp, #48
	bl	_write
	ldr	w8, [sp, #36]
	tbz	w8, #0, LBB27_15
	ldr	x0, [sp, #40]
	add	sp, sp, #1, lsl #12
	add	sp, sp, #64
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	b	"_std::io::io::_flush(::FileDescriptor)"
LBB27_15:
	add	sp, sp, #1, lsl #12
	add	sp, sp, #64
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
	.cfi_endproc

	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0
lCPI28_0:
	.quad	192
	.quad	2305843009213693952
lCPI28_1:
	.quad	1
	.quad	2305843009213693952
lCPI28_2:
	.quad	2
	.quad	2305843009213693952
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	2
"_std::random::_rng::_get_global_random_state()":
	.cfi_startproc
	sub	sp, sp, #144
	stp	x29, x30, [sp, #128]
	.cfi_def_cfa_offset 144
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh216:
	adrp	x0, _static_string_57a1f4424b341bb2@PAGE
Lloh217:
	add	x0, x0, _static_string_57a1f4424b341bb2@PAGEOFF
Lloh218:
	adrp	x2, "_std::ffi::__init__::_Global::get_or_create_ptr(),StorageType=[typevalue<#kgen.instref<\"std::random::_rng::_RandomState\">>, struct<(struct<(struct<(simd<2, ui32>, simd<4, ui32>) memoryOnly>, simd<4, ui32>, index) memoryOnly>) memoryOnly>],name={ #interp.memref<{[(#interp.memory_handle<16, \"random_state\\00\" string>, const_global, [], [])], []}, 0, 0>, 12 },init_fn=\"std::random::_rng::_init_random_state()\",on_error_msg={ { { {:struct<()> {  }, 0} } } }_closure_0"@GOTPAGE
Lloh219:
	ldr	x2, [x2, "_std::ffi::__init__::_Global::get_or_create_ptr(),StorageType=[typevalue<#kgen.instref<\"std::random::_rng::_RandomState\">>, struct<(struct<(struct<(simd<2, ui32>, simd<4, ui32>) memoryOnly>, simd<4, ui32>, index) memoryOnly>) memoryOnly>],name={ #interp.memref<{[(#interp.memory_handle<16, \"random_state\\00\" string>, const_global, [], [])], []}, 0, 0>, 12 },init_fn=\"std::random::_rng::_init_random_state()\",on_error_msg={ { { {:struct<()> {  }, 0} } } }_closure_0"@GOTPAGEOFF]
Lloh220:
	adrp	x3, "_std::ffi::__init__::_Global::_deinit_wrapper(::Optional[::UnsafePointer[::Bool(True), {}, ::NoneType, *?, ::AddressSpace(::Int(0))]]),StorageType=[typevalue<#kgen.instref<\"std::random::_rng::_RandomState\">>, struct<(struct<(struct<(simd<2, ui32>, simd<4, ui32>) memoryOnly>, simd<4, ui32>, index) memoryOnly>) memoryOnly>],name={ #interp.memref<{[(#interp.memory_handle<16, \"random_state\\00\" string>, const_global, [], [])], []}, 0, 0>, 12 },init_fn=\"std::random::_rng::_init_random_state()\",on_error_msg={ { { {:struct<()> {  }, 0} } } }"@GOTPAGE
Lloh221:
	ldr	x3, [x3, "_std::ffi::__init__::_Global::_deinit_wrapper(::Optional[::UnsafePointer[::Bool(True), {}, ::NoneType, *?, ::AddressSpace(::Int(0))]]),StorageType=[typevalue<#kgen.instref<\"std::random::_rng::_RandomState\">>, struct<(struct<(struct<(simd<2, ui32>, simd<4, ui32>) memoryOnly>, simd<4, ui32>, index) memoryOnly>) memoryOnly>],name={ #interp.memref<{[(#interp.memory_handle<16, \"random_state\\00\" string>, const_global, [], [])], []}, 0, 0>, 12 },init_fn=\"std::random::_rng::_init_random_state()\",on_error_msg={ { { {:struct<()> {  }, 0} } } }"@GOTPAGEOFF]
	mov	w1, #12
	bl	_KGEN_CompilerRT_GetOrCreateGlobal
	cbz	x0, LBB28_2
	ldp	x29, x30, [sp, #128]
	add	sp, sp, #144
	ret
LBB28_2:
Lloh222:
	adrp	x8, _static_string_f9c5d72f244f07d1@PAGE
Lloh223:
	add	x9, x8, _static_string_f9c5d72f244f07d1@PAGEOFF
Lloh224:
	adrp	x8, lCPI28_0@PAGE
Lloh225:
	ldr	q0, [x8, lCPI28_0@PAGEOFF]
	stur	q0, [sp, #64]
Lloh226:
	adrp	x8, _static_string_a8d4ace0dc8d360e@PAGE
Lloh227:
	add	x8, x8, _static_string_a8d4ace0dc8d360e@PAGEOFF
	str	x8, [sp, #80]
Lloh228:
	adrp	x8, lCPI28_1@PAGE
Lloh229:
	ldr	q0, [x8, lCPI28_1@PAGEOFF]
	stur	q0, [sp, #88]
Lloh230:
	adrp	x8, _static_string_7f1562353e292282@PAGE
Lloh231:
	add	x8, x8, _static_string_7f1562353e292282@PAGEOFF
	str	x8, [sp, #104]
Lloh232:
	adrp	x8, lCPI28_2@PAGE
Lloh233:
	ldr	q0, [x8, lCPI28_2@PAGEOFF]
	stur	q0, [sp, #112]
	mov	w8, #1
	stp	x8, x9, [sp, #48]
	strb	w8, [sp, #40]
	str	x8, [sp, #32]
Lloh234:
	adrp	x8, _static_string_bbe01a6a523daf15@PAGE
Lloh235:
	add	x8, x8, _static_string_bbe01a6a523daf15@PAGEOFF
	stp	xzr, x8, [sp, #16]
Lloh236:
	adrp	x8, _static_string_c44bdff4074eecdb@PAGE
Lloh237:
	add	x8, x8, _static_string_c44bdff4074eecdb@PAGEOFF
	add	x9, sp, #56
Lloh238:
	adrp	x0, _static_string_31203c1a2bdb78cc@PAGE
Lloh239:
	add	x0, x0, _static_string_31203c1a2bdb78cc@PAGEOFF
Lloh240:
	adrp	x5, _static_string_021076ac7eeae71f@PAGE
Lloh241:
	add	x5, x5, _static_string_021076ac7eeae71f@PAGEOFF
	add	x2, sp, #80
	add	x7, sp, #104
	stp	x9, x8, [sp]
	mov	w1, #6
	mov	w3, #937
	mov	w4, #61
	mov	w6, #45
	bl	"_std::io::io::print[KGENParamList[::Writable],*::Writable,LITImmutOrigin,::Origin[::Bool(False), $2]](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts.values`=[[typevalue<#kgen.instref<\"std::collections::string::string_slice::StringSlice,mut=0,origin._mlir_origin`={  },origin={  }\">>, struct<(pointer<none>, index)>], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::reflection::location::SourceLocation\">>, struct<(index, index, struct<(pointer<none>, index)>)>], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>]]"
	ldrb	w8, [sp, #103]
	tbz	w8, #6, LBB28_5
	ldr	x8, [sp, #80]
	sub	x0, x8, #8
	mov	x8, #-1
	ldaddal	x8, x8, [x0]
	cmp	x8, #1
	b.ne	LBB28_5
	dmb	ishld
	bl	_KGEN_CompilerRT_AlignedFree
LBB28_5:
	ldrb	w8, [sp, #127]
	tbz	w8, #6, LBB28_8
	ldr	x8, [sp, #104]
	sub	x0, x8, #8
	mov	x8, #-1
	ldaddal	x8, x8, [x0]
	cmp	x8, #1
	b.ne	LBB28_8
	dmb	ishld
	bl	_KGEN_CompilerRT_AlignedFree
LBB28_8:
	brk	#0x1
	.loh AdrpLdrGot	Lloh220, Lloh221
	.loh AdrpLdrGot	Lloh218, Lloh219
	.loh AdrpAdd	Lloh216, Lloh217
	.loh AdrpAdd	Lloh240, Lloh241
	.loh AdrpAdd	Lloh238, Lloh239
	.loh AdrpAdd	Lloh236, Lloh237
	.loh AdrpAdd	Lloh234, Lloh235
	.loh AdrpLdr	Lloh232, Lloh233
	.loh AdrpAdd	Lloh230, Lloh231
	.loh AdrpAdrp	Lloh228, Lloh230
	.loh AdrpLdr	Lloh228, Lloh229
	.loh AdrpAdd	Lloh226, Lloh227
	.loh AdrpAdrp	Lloh224, Lloh226
	.loh AdrpLdr	Lloh224, Lloh225
	.loh AdrpAdrp	Lloh222, Lloh224
	.loh AdrpAdd	Lloh222, Lloh223
	.cfi_endproc

	.section	__TEXT,__const
	.p2align	4, 0x0
_static_string_6dc38af2f39195e4:
	.asciz	"/tmp/build/bench_dot_product.mojo"

	.p2align	4, 0x0
_static_string_a61c3395ab9379d9:
	.asciz	"Runtime"

	.p2align	4, 0x0
_static_string_51c95ecb49d4d75a:
	.asciz	"MOJO_KEY mojo_simd_result"

	.p2align	4, 0x0
_static_string_1618a6be9bfb1861:
	.asciz	"MOJO_KEY mojo_simd_best_ns"

	.p2align	4, 0x0
_static_string_7a6237f4a9cb54dc:
	.asciz	"MOJO_KEY mojo_scalar_result"

	.p2align	4, 0x0
_static_string_9e3f690336f5b872:
	.asciz	"MOJO_KEY mojo_scalar_best_ns"

	.p2align	4, 0x0
_static_string_91654eea92a30b37:
	.asciz	"MOJO_KEY hardware_simd_width"

	.p2align	4, 0x0
_static_string_302229805fc33311:
	.asciz	"MOJO_KEY n_elements"

	.p2align	4, 0x0
_static_string_e5411518d45eb182:
	.asciz	"nan"

	.p2align	4, 0x0
_static_string_a8e3dd8c929b6eb8:
	.asciz	"-"

	.p2align	4, 0x0
_static_string_978d8d34847e5196:
	.asciz	"0123456789abcdefghijklmnopqrstuvwxyz"

	.p2align	4, 0x0
_static_string_09e773a88105e290:
	.asciz	"alloc failed: returned a null pointer"

	.p2align	4, 0x0
_static_string_e076905c259bf94f:
	.asciz	"oss/modular/mojo/stdlib/std/memory/unsafe_pointer.mojo"

	.p2align	4, 0x0
_static_string_ffe5c571af8dd3fc:
	.asciz	"index "

	.p2align	4, 0x0
_static_string_a0fcf35b7349c924:
	.asciz	" is out of bounds, valid range is 0 to "

	.p2align	4, 0x0
_static_string_cfa776fe0f373673:
	.asciz	"oss/modular/mojo/stdlib/std/builtin/_format_float.mojo"

	.p2align	4, 0x0
_global_constant:
	.quad	2731688931043774331
	.quad	-38366372719436721
	.quad	8624834609543440813
	.quad	-6941508010590729807
	.quad	-3054014793352862696
	.quad	-4065198994811024355
	.quad	5405853545163697438
	.quad	-469812725086392539
	.quad	5684501474941004851
	.quad	-7211161980820077193
	.quad	2493940825248868160
	.quad	-4402266457597708587
	.quad	7729112049988473104
	.quad	-891147053569747830
	.quad	-9004363024039368022
	.quad	-7474495936122174250
	.quad	2579604275232953684
	.quad	-4731433901725329908
	.quad	3224505344041192105
	.quad	-1302606358729274481
	.quad	8932844867666826922
	.quad	-7731658001846878407
	.quad	-2669001970698630060
	.quad	-5052886483881210105
	.quad	-3336252463373287575
	.quad	-1704422086424124727
	.quad	2526528228819083170
	.quad	-7982792831656159810
	.quad	-6065211750830921845
	.quad	-5366805021142811859
	.quad	1641857348316123501
	.quad	-2096820258001126919
	.quad	-5891368184943504668
	.quad	-8228041688891786181
	.quad	-7364210231179380835
	.quad	-5673366092687344822
	.quad	4629795266307937668
	.quad	-2480021597431793123
	.quad	5199465050656154995
	.quad	-8467542526035952558
	.quad	-2724040723534582064
	.quad	-5972742139117552794
	.quad	-8016736922845615485
	.quad	-2854241655469553088
	.quad	6518754469289960082
	.quad	-8701430062309552536
	.quad	8148443086612450103
	.quad	-6265101559459552766
	.quad	962181821410786820
	.quad	-3219690930897053053
	.quad	-1704479370831952189
	.quad	-8929835859451740015
	.quad	7092772823314835571
	.quad	-6550608805887287114
	.quad	-357406007711231344
	.quad	-3576574988931720989
	.quad	8999993282035256218
	.quad	-9152888395723407474
	.quad	2026619565689294465
	.quad	-6829424476226871438
	.quad	-6690097579743157727
	.quad	-3925094576856201394
	.quad	5472436080603216553
	.quad	-294682202642863838
	.quad	8031958568804398250
	.quad	-7101705404292871755
	.quad	-3795109844276665900
	.quad	-4265445736938701790
	.quad	9091170749936331337
	.quad	-720121152745989333
	.quad	3376138709496513134
	.quad	-7367604748107325189
	.quad	-391512631556746487
	.quad	-4597819916706768583
	.quad	8733981247408842699
	.quad	-1135588877456072824
	.quad	5458738279630526687
	.quad	-7627272076051127371
	.quad	-7011635205744005353
	.quad	-4922404076636521310
	.quad	5070514048102157021
	.quad	-1541319077368263733
	.quad	863228270850154186
	.quad	-7880853450996246689
	.quad	-3532650679864695172
	.quad	-5239380795317920458
	.quad	-9027499368258256869
	.quad	-1937539975720012668
	.quad	-3336344095947716591
	.quad	-8128491512466089774
	.quad	-8782116138362033642
	.quad	-5548928372155224313
	.quad	7469098900757009563
	.quad	-2324474446766642487
	.quad	-2249342214667950879
	.quad	-8370325556870233411
	.quad	6411694268519837209
	.quad	-5851220927660403859
	.quad	-5820440219632367201
	.quad	-2702340141148116920
	.quad	7891439908798240260
	.quad	-8606491615858654931
	.quad	-3970758169284363388
	.quad	-6146428501395930760
	.quad	-351761693178066331
	.quad	-3071349608317525546
	.quad	6697677969404790400
	.quad	-8837122532839535322
	.quad	-851274575098787809
	.quad	-6434717147622031249
	.quad	-1064093218873484761
	.quad	-3431710416100151157
	.quad	8558313775058847833
	.quad	-9062348037703676329
	.quad	6086206200396171887
	.quad	-6716249028702207507
	.quad	-6227300304786948854
	.quad	-3783625267450371480
	.quad	-3172439362556298163
	.quad	-117845565885576446
	.quad	-4288617610811380304
	.quad	-6991182506319567135
	.quad	3862600023340550428
	.quad	-4127292114472071014
	.quad	-4395122007679087773
	.quad	-547429124662700864
	.quad	8782263791269039902
	.quad	-7259672230555269896
	.quad	-7468914334623251739
	.quad	-4462904269766699466
	.quad	4498915137003099038
	.quad	-966944318780986428
	.quad	-6411550076227838909
	.quad	-7521869226879198374
	.quad	5820620459997365076
	.quad	-4790650515171610063
	.quad	-6559282480285457367
	.quad	-1376627125537124675
	.quad	-8711237568605798758
	.quad	-7777920981101784778
	.quad	2946011094524915264
	.quad	-5110715207949843068
	.quad	3682513868156144080
	.quad	-1776707991509915931
	.quad	4607414176811284002
	.quad	-8027971522334779313
	.quad	1147581702586717098
	.quad	-5423278384491086237
	.quad	-3177208890193991531
	.quad	-2167411962186469893
	.quad	7237616480483531101
	.quad	-8272161504007625539
	.quad	-4788037454677749836
	.quad	-5728515861582144020
	.quad	-1373360799919799391
	.quad	-2548958808550292121
	.quad	-858350499949874619
	.quad	-8510628282985014432
	.quad	3538747893490044630
	.quad	-6026599335303880135
	.quad	9035120885289943692
	.quad	-2921563150702462265
	.quad	-5882264492762254952
	.quad	-8743505996830120772
	.quad	-2741144597525430787
	.quad	-6317696477610263061
	.quad	-3426430746906788484
	.quad	-3285434578585440922
	.quad	4776009810824339054
	.quad	-8970925639256982432
	.quad	5970012263530423817
	.quad	-6601971030643840136
	.quad	7462515329413029772
	.quad	-3640777769877412266
	.quad	52386062455755703
	.quad	-9193015133814464522
	.quad	-9157889458785081179
	.quad	-6879582898840692749
	.quad	6999382250228200142
	.quad	-3987792605123478032
	.quad	8749227812785250178
	.quad	-373054737976959636
	.quad	-3755104653863994447
	.quad	-7150688238876681629
	.quad	-4693880817329993059
	.quad	-4326674280168464132
	.quad	-1255665003235103419
	.quad	-796656831783192261
	.quad	8438581409832836171
	.quad	-7415439547505577019
	.quad	-3286831292991118498
	.quad	-4657613415954583370
	.quad	-8720225134666286027
	.quad	-1210330751515841308
	.quad	-3144297699952734815
	.quad	-7673985747338482674
	.quad	-8542058143368306422
	.quad	-4980796165745715438
	.quad	3157485376071780684
	.quad	-1614309188754756393
	.quad	8890957387685944784
	.quad	-7926472270612804602
	.quad	1890324697752655171
	.quad	-5296404319838617848
	.quad	2362905872190818964
	.quad	-2008819381370884406
	.quad	6088502188546649757
	.quad	-8173041140997884610
	.quad	-1612744301171463612
	.quad	-5604615407819967859
	.quad	7207441660390446293
	.quad	-2394083241347571919
	.quad	-2412877989897052923
	.quad	-8413831053483314306
	.quad	-7627783505798704058
	.quad	-5905602798426754978
	.quad	4300328673033783640
	.quad	-2770317479606055818
	.quad	-1923980597781273129
	.quad	-8648977452394866743
	.quad	6818396289628184397
	.quad	-6199535797066195524
	.quad	8522995362035230496
	.quad	-3137733727905356501
	.quad	3021029092058325108
	.quad	-8878612607581929669
	.quad	-835399653354481519
	.quad	-6486579741050024183
	.quad	8179122470161673909
	.quad	-3496538657885142324
	.quad	-4111420493003729615
	.quad	-9102865688819295809
	.quad	-5139275616254662019
	.quad	-6766896092596731857
	.quad	-6424094520318327523
	.quad	-3846934097318526917
	.quad	-8030118150397909404
	.quad	-196981603220770742
	.quad	-7324666853212387329
	.quad	-7040642529654063570
	.quad	4679224488766679550
	.quad	-4189117143640191558
	.quad	-3374341425896426371
	.quad	-624710411122851544
	.quad	-9026492418826348337
	.quad	-7307973034592864071
	.quad	-2059743486678159614
	.quad	-4523280274813692185
	.quad	-2574679358347699518
	.quad	-1042414325089727327
	.quad	3002511419460075706
	.quad	-7569037980822161435
	.quad	8364825292752482536
	.quad	-4849611457600313890
	.quad	1232659579085827362
	.quad	-1450328303573004458
	.quad	-3841273781498745803
	.quad	-7823984217374209643
	.quad	4421779809981343555
	.quad	-5168294253290374149
	.quad	915538744049291539
	.quad	-1848681798185579782
	.quad	5183897733458195116
	.quad	-8072955151507069220
	.quad	6479872166822743895
	.quad	-5479507920956448621
	.quad	3488154190101041965
	.quad	-2237698882768172872
	.quad	2180096368813151228
	.quad	-8316090829371189901
	.quad	-1886565557410948869
	.quad	-5783427518286599473
	.quad	-2358206946763686086
	.quad	-2617598379430861437
	.quad	7749492695127472004
	.quad	-8553528014785370254
	.quad	463493832054564197
	.quad	-6080224000054324913
	.quad	-4032318728359182658
	.quad	-2988593981640518238
	.quad	-4826042214438183113
	.quad	-8785400266166405755
	.quad	3190819268807046917
	.quad	-6370064314280619289
	.quad	-623161932418579258
	.quad	-3350894374423386208
	.quad	-7307005235402693892
	.quad	-9011838011655698236
	.quad	-4522070525825979461
	.quad	-6653111496142234891
	.quad	3570783879572301481
	.quad	-3704703351750405709
	.quad	-148206168962011053
	.quad	-19193171260619233
	.quad	-92628855601256908
	.quad	-6929524759678968877
	.quad	-115786069501571135
	.quad	-4050219931171323192
	.quad	4466953431550423985
	.quad	-451088895536766085
	.quad	486002885505321039
	.quad	-7199459587351560659
	.quad	5219189625309039203
	.quad	-4387638465762062920
	.quad	6523987031636299003
	.quad	-872862063775190746
	.quad	-534194123654701027
	.quad	-7463067817500576073
	.quad	-667742654568376284
	.quad	-4717148753448332187
	.quad	8388693718644305453
	.quad	-1284749923383027329
	.quad	-6286281471915778851
	.quad	-7720497729755473937
	.quad	-7857851839894723564
	.quad	-5038936143766954517
	.quad	8624429273841147160
	.quad	-1686984161281305242
	.quad	778582277723329071
	.quad	-7971894128441897632
	.quad	973227847154161339
	.quad	-5353181642124984136
	.quad	1216534808942701674
	.quad	-2079791034228842266
	.quad	-3851351762838199358
	.quad	-8217398424034108273
	.quad	-4814189703547749197
	.quad	-5660062011615247437
	.quad	-6017737129434686497
	.quad	-2463391496091671392
	.quad	7768129340171790700
	.quad	-8457148712698376476
	.quad	-8736582398494813241
	.quad	-5959749872445582691
	.quad	-1697355961263740744
	.quad	-2838001322129590460
	.quad	1244995533423855987
	.quad	-8691279853972075893
	.quad	-3055441601647567920
	.quad	-6252413799037706963
	.quad	5404070034795315908
	.quad	-3203831230369745799
	.quad	-3539985255894009413
	.quad	-8919923546622172981
	.quad	-4424981569867511767
	.quad	-6538218414850328322
	.quad	8303831092947774003
	.quad	-3561087000135522498
	.quad	578208414664970848
	.quad	-9143208402725783417
	.quad	-3888925500096174344
	.quad	-6817324484979841368
	.quad	-249470856692830026
	.quad	-3909969587797413806
	.quad	-4923524589293425437
	.quad	-275775966319379353
	.quad	-3077202868308390898
	.quad	-7089889006590693952
	.quad	765182433041899282
	.quad	-4250675239810979535
	.quad	5568164059729762006
	.quad	-701658031336336515
	.quad	5785945546544795206
	.quad	-7356065297226292178
	.quad	-1990940103673781801
	.quad	-4583395603105477319
	.quad	6734696907262548557
	.quad	-1117558485454458744
	.quad	4209185567039092848
	.quad	-7616003081050118571
	.quad	-8573576096483297652
	.quad	-4908317832885260310
	.quad	3118087934678041647
	.quad	-1523711272679187483
	.quad	4254647968387469982
	.quad	-7869848573065574033
	.quad	706623942056949573
	.quad	-5225624697904579637
	.quad	-3728406090856200938
	.quad	-1920344853953336643
	.quad	-6941939825212513490
	.quad	-8117744561361917258
	.quad	5157633273766521850
	.quad	-5535494683275008668
	.quad	6447041592208152312
	.quad	-2307682335666372931
	.quad	6335244004343789147
	.quad	-8359830487432564938
	.quad	-1304317031425039374
	.quad	-5838102090863318269
	.quad	-1630396289281299218
	.quad	-2685941595151759932
	.quad	1286845328412881941
	.quad	-8596242524610931813
	.quad	-3003129357911285478
	.quad	-6133617137336276863
	.quad	5469460339465668960
	.quad	-3055335403242958174
	.quad	8030098730593431004
	.quad	-8827113654667930715
	.quad	-3797434642040374957
	.quad	-6422206049907525490
	.quad	9088264752731695016
	.quad	-3416071543957018958
	.quad	-8154892584824854327
	.quad	-9052573742614218705
	.quad	8253128342678483707
	.quad	-6704031159840385477
	.quad	5704724409920716730
	.quad	-3768352931373093942
	.quad	-2092466524453879895
	.quad	-98755145788979524
	.quad	998051431430019018
	.quad	-6979250993759194058
	.quad	-7975807747567252036
	.quad	-4112377723771604669
	.quad	8476984389250486571
	.quad	-528786136287117932
	.quad	-3925256793573221701
	.quad	-7248020362820530564
	.quad	-294884973539139223
	.quad	-4448339435098275301
	.quad	-368606216923924028
	.quad	-948738275445456222
	.quad	-2536221894791146469
	.quad	-7510490449794491995
	.quad	6053094668365842721
	.quad	-4776427043815727089
	.quad	2954682317029915497
	.quad	-1358847786342270957
	.quad	-459166561069996766
	.quad	-7766808894105001205
	.quad	-573958201337495958
	.quad	-5096825099203863602
	.quad	-5329133770099257851
	.quad	-1759345355577441598
	.quad	-5636551615525730109
	.quad	-8017119874876982855
	.quad	2177682517447613172
	.quad	-5409713825168840664
	.quad	2722103146809516465
	.quad	-2150456263033662926
	.quad	6313000485183335695
	.quad	-8261564192037121185
	.quad	3279564588051781714
	.quad	-5715269221619013577
	.quad	-512230283362660762
	.quad	-2532400508596379068
	.quad	1985699082112030976
	.quad	-8500279345513818773
	.quad	-2129562165787349184
	.quad	-6013663163464885563
	.quad	6561419329620589328
	.quad	-2905392935903719049
	.quad	-7428327965055601430
	.quad	-8733399612580906262
	.quad	4549648098962661925
	.quad	-6305063497298744923
	.quad	-8147997931578836306
	.quad	-3269643353196043250
	.quad	1825030320404309165
	.quad	-8961056123388608887
	.quad	6892973918932774360
	.quad	-6589634135808373205
	.quad	4004531380238580046
	.quad	-3625356651333078602
	.quad	-2108853905778275375
	.quad	-9183376934724255983
	.quad	6587304654631931589
	.quad	-6867535149977932074
	.quad	-989241218564861322
	.quad	-3972732919045027189
	.quad	-1236551523206076653
	.quad	-354230130378896082
	.quad	6144684325637283948
	.quad	-7138922859127891907
	.quad	-6154202648235558777
	.quad	-4311967555482476980
	.quad	-3081067291867060567
	.quad	-778273425925708321
	.quad	-1925667057416912854
	.quad	-7403949918844649557
	.quad	-2407083821771141068
	.quad	-4643251380128424042
	.quad	-7620540795641314239
	.quad	-1192378206733142148
	.quad	-2456994988062127447
	.quad	-7662765406849295699
	.quad	6152128301777116499
	.quad	-4966770740134231719
	.quad	-6144897678060768089
	.quad	-1596777406740401745
	.quad	-3840561048787980055
	.quad	-7915514906853832947
	.quad	4422670725869800739
	.quad	-5282707615139903279
	.quad	-8306719647944912789
	.quad	-1991698500497491195
	.quad	8643358275316593219
	.quad	-8162340590452013853
	.quad	6192511825718353620
	.quad	-5591239719637629412
	.quad	7740639782147942025
	.quad	-2377363631119648861
	.quad	2532056854628769814
	.quad	-8403381297090862394
	.quad	-6058300968568813541
	.quad	-5892540602936190089
	.quad	-7572876210711016926
	.quad	-2753989735242849707
	.quad	9102010423587778133
	.quad	-8638772612167862923
	.quad	-2457545025797441046
	.quad	-6186779746782440750
	.quad	-7683617300674189211
	.quad	-3121788665050663033
	.quad	-4802260812921368257
	.quad	-8868646943297746252
	.quad	-1391139997724322417
	.quad	-6474122660694794911
	.quad	7484447039699372787
	.quad	-3480967307441105734
	.quad	-9157278655470055720
	.quad	-9093133594791772940
	.quad	-6834912300910181746
	.quad	-6754730975062328271
	.quad	679731660717048625
	.quad	-3831727700400522434
	.quad	-8373707460958465027
	.quad	-177973607073265139
	.quad	8601490892183123070
	.quad	-7028762532061872568
	.quad	-7694880458480647778
	.quad	-4174267146649952806
	.quad	4216457482181353989
	.quad	-606147914885053103
	.quad	-4282243101277735613
	.quad	-7296371474444240046
	.quad	8482254178684994196
	.quad	-4508778324627912153
	.quad	5991131704928854841
	.quad	-1024286887357502287
	.quad	-3173071712060547580
	.quad	-7557708332239520786
	.quad	-8578025658503072379
	.quad	-4835449396872013078
	.quad	3112525982153323238
	.quad	-1432625727662628443
	.quad	4251171748059520976
	.quad	-7812920107430224633
	.quad	702278666647013315
	.quad	-5154464115860392887
	.quad	5489534351736154548
	.quad	-1831394126398103205
	.quad	1125115960621402641
	.quad	-8062150356639896359
	.quad	6018080969204141205
	.quad	-5466001927372482545
	.quad	2910915193077788602
	.quad	-2220816390788215277
	.quad	-486521013540076076
	.quad	-8305539271883716405
	.quad	-608151266925095095
	.quad	-5770238071427257602
	.quad	-5371875102083756772
	.quad	-2601111570856684098
	.quad	3560107088838733873
	.quad	-8543223759426509417
	.quad	-161552157378970562
	.quad	-6067343680855748868
	.quad	4409745821703674701
	.quad	-2972493582642298180
	.quad	-6467280898289979120
	.quad	-8775337516792518219
	.quad	1139270913992301908
	.quad	-6357485877563259869
	.quad	-3187597375937010519
	.quad	-3335171328526686933
	.quad	7231123676894144234
	.quad	-9002011107970261189
	.quad	4427218577690292388
	.quad	-6640827866535438582
	.quad	-3689348814741910323
	.quad	-3689348814741910324
	.quad	0
	.quad	-9223372036854775808
	.quad	0
	.quad	-6917529027641081856
	.quad	0
	.quad	-4035225266123964416
	.quad	0
	.quad	-432345564227567616
	.quad	0
	.quad	-7187745005283311616
	.quad	0
	.quad	-4372995238176751616
	.quad	0
	.quad	-854558029293551616
	.quad	0
	.quad	-7451627795949551616
	.quad	0
	.quad	-4702848726509551616
	.quad	0
	.quad	-1266874889709551616
	.quad	0
	.quad	-7709325833709551616
	.quad	0
	.quad	-5024971273709551616
	.quad	0
	.quad	-1669528073709551616
	.quad	0
	.quad	-7960984073709551616
	.quad	0
	.quad	-5339544073709551616
	.quad	0
	.quad	-2062744073709551616
	.quad	0
	.quad	-8206744073709551616
	.quad	0
	.quad	-5646744073709551616
	.quad	0
	.quad	-2446744073709551616
	.quad	0
	.quad	-8446744073709551616
	.quad	0
	.quad	-5946744073709551616
	.quad	0
	.quad	-2821744073709551616
	.quad	0
	.quad	-8681119073709551616
	.quad	0
	.quad	-6239712823709551616
	.quad	0
	.quad	-3187955011209551616
	.quad	0
	.quad	-8910000909647051616
	.quad	0
	.quad	-6525815118631426616
	.quad	0
	.quad	-3545582879861895366
	.quad	4611686018427387904
	.quad	-9133518327554766460
	.quad	5764607523034234880
	.quad	-6805211891016070171
	.quad	-6629298651489370112
	.quad	-3894828845342699810
	.quad	5548434740920451072
	.quad	-256850038250986858
	.quad	-1143914305352105984
	.quad	-7078060301547948643
	.quad	7793479155164643328
	.quad	-4235889358507547899
	.quad	-4093209111326359552
	.quad	-683175679707046970
	.quad	4359273333062107136
	.quad	-7344513827457986212
	.quad	5449091666327633920
	.quad	-4568956265895094861
	.quad	2199678564482154496
	.quad	-1099509313941480672
	.quad	1374799102801346560
	.quad	-7604722348854507276
	.quad	1718498878501683200
	.quad	-4894216917640746191
	.quad	6759809616554491904
	.quad	-1506085128623544835
	.quad	6530724019560251392
	.quad	-7858832233030797378
	.quad	-1059967012404461568
	.quad	-5211854272861108819
	.quad	7898413271349198848
	.quad	-1903131822648998119
	.quad	-1981020733047832576
	.quad	-8106986416796705681
	.quad	-2476275916309790720
	.quad	-5522047002568494197
	.quad	-3095344895387238400
	.quad	-2290872734783229842
	.quad	4982938468024057856
	.quad	-8349324486880600507
	.quad	-7606384970252091392
	.quad	-5824969590173362730
	.quad	4327076842467049472
	.quad	-2669525969289315508
	.quad	-6518949010312869888
	.quad	-8585982758446904049
	.quad	-8148686262891087360
	.quad	-6120792429631242157
	.quad	8260886245095692416
	.quad	-3039304518611664792
	.quad	5163053903184807760
	.quad	-8817094351773372351
	.quad	-7381240676301154012
	.quad	-6409681921289327535
	.quad	-3178808521666707
	.quad	-3400416383184271515
	.quad	-4613672773753429595
	.quad	-9042789267131251553
	.quad	-5767090967191786994
	.quad	-6691800565486676537
	.quad	-7208863708989733743
	.quad	-3753064688430957767
	.quad	212292400617608629
	.quad	-79644842111309304
	.quad	132682750386005393
	.quad	-6967307053960650171
	.quad	4777539456409894646
	.quad	-4097447799023424810
	.quad	-3251447716342407501
	.quad	-510123730351893109
	.quad	7191217214140771120
	.quad	-7236356359111015049
	.quad	4377335499248575996
	.quad	-4433759430461380907
	.quad	-8363388681221443717
	.quad	-930513269649338230
	.quad	-7532960934977096275
	.quad	-7499099821171918250
	.quad	4418856886560793368
	.quad	-4762188758037509908
	.quad	5523571108200991710
	.quad	-1341049929119499481
	.quad	-8076983103442849941
	.quad	-7755685233340769032
	.quad	-5484542860876174523
	.quad	-5082920523248573386
	.quad	6979379479186945559
	.quad	-1741964635633328828
	.quad	-4861259862362934834
	.quad	-8006256924911912374
	.quad	7758483227328495170
	.quad	-5396135137712502563
	.quad	-4136954021121544750
	.quad	-2133482903713240300
	.quad	-279753253987271517
	.quad	-8250955842461857044
	.quad	4261994450943298508
	.quad	-5702008784649933400
	.quad	5327493063679123135
	.quad	-2515824962385028846
	.quad	7941369183226839864
	.quad	-8489919629131724885
	.quad	5315025460606161925
	.quad	-6000713517987268202
	.quad	-2579590211097073401
	.quad	-2889205879056697349
	.quad	7611128154919104932
	.quad	-8723282702051517699
	.quad	-4321147861633282547
	.quad	-6292417359137009220
	.quad	-789748808614215279
	.quad	-3253835680493873621
	.quad	8729779031470891259
	.quad	-8951176327949752869
	.quad	6300537770911226169
	.quad	-6577284391509803182
	.quad	-1347699823215743097
	.quad	-3609919470959866074
	.quad	6075216638131242421
	.quad	-9173728696990998152
	.quad	7594020797664053026
	.quad	-6855474852811359786
	.quad	269153960225290474
	.quad	-3957657547586811828
	.quad	336442450281613092
	.quad	-335385916056126881
	.quad	7127805559067090039
	.quad	-7127145225176161157
	.quad	4298070930406474645
	.quad	-4297245513042813542
	.quad	-3850783373846682502
	.quad	-759870872876129024
	.quad	9122475437414293196
	.quad	-7392448323188662496
	.quad	-7043649776941685121
	.quad	-4628874385558440216
	.quad	-4192876202749718497
	.quad	-1174406963520662366
	.quad	-4926390635932268013
	.quad	-7651533379841495835
	.quad	3065383741939440792
	.quad	-4952730706374481889
	.quad	-779956341003086914
	.quad	-1579227364540714458
	.quad	6430056314514152535
	.quad	-7904546130479028392
	.quad	8037570393142690669
	.quad	-5268996644671397586
	.quad	823590954573587528
	.quad	-1974559787411859078
	.quad	5126430365035880109
	.quad	-8151628894773493780
	.quad	6408037956294850136
	.quad	-5577850100039479321
	.quad	3398361426941174766
	.quad	-2360626606621961247
	.quad	-4793553135802847627
	.quad	-8392920656779807636
	.quad	-1380255401326171630
	.quad	-5879464802547371641
	.quad	-1725319251657714538
	.quad	-2737644984756826647
	.quad	3533361486141316318
	.quad	-8628557143114098510
	.quad	-4806670179178130410
	.quad	-6174010410465235234
	.quad	7826720331309500699
	.quad	-3105826994654156138
	.quad	280014188641050033
	.quad	-8858670899299929442
	.quad	-8873354301053463267
	.quad	-6461652605697523899
	.quad	-1868320839462053276
	.quad	-3465379738694516970
	.quad	5749828502977298559
	.quad	-9083391364325154962
	.quad	-2036086408133152610
	.quad	-6742553186979055799
	.quad	6678264026688335046
	.quad	-3816505465296431844
	.quad	8347830033360418807
	.quad	-158945813193151901
	.quad	2911550761636567803
	.quad	-7016870160886801794
	.quad	-5583933584809066055
	.quad	-4159401682681114339
	.quad	2243455055843443239
	.quad	-587566084924005019
	.quad	3708002419115845977
	.quad	-7284757830718584993
	.quad	23317005467419567
	.quad	-4494261269970843337
	.quad	-4582539761593113445
	.quad	-1006140569036166268
	.quad	-558244341782001951
	.quad	-7546366883288685774
	.quad	-5309491445654890343
	.quad	-4821272585683469313
	.quad	-6636864307068612929
	.quad	-1414904713676948737
	.quad	-4148040191917883080
	.quad	-7801844473689174817
	.quad	-5185050239897353851
	.quad	-5140619573684080617
	.quad	-6481312799871692314
	.quad	-1814088448677712867
	.quad	-8662506518347195600
	.quad	-8051334308064652398
	.quad	3006924907348169212
	.quad	-5452481866653427593
	.quad	-853029884242176389
	.quad	-2203916314889396588
	.quad	1772699331562333709
	.quad	-8294976724446954723
	.quad	6827560182880305040
	.quad	-5757034887131305500
	.quad	8534450228600381300
	.quad	-2584607590486743971
	.quad	7639874402088932265
	.quad	-8532908771695296838
	.quad	326470965756389523
	.quad	-6054449946191733143
	.quad	5019774725622874807
	.quad	-2956376414312278525
	.quad	831516194300602803
	.quad	-8765264286586255934
	.quad	-8183976793979022305
	.quad	-6344894339805432014
	.quad	3605087062808385831
	.quad	-3319431906329402113
	.quad	9170708441896323001
	.quad	-8992173969096958177
	.quad	6851699533943015847
	.quad	-6628531442943809817
	.quad	3952938399001381904
	.quad	-3673978285252374367
	.quad	-4446942528265218166
	.quad	-9213765455923815836
	.quad	-946992141904134803
	.quad	-6905520801477381891
	.quad	8039631859474607304
	.quad	-4020214983419339459
	.quad	-3785518230938904582
	.quad	-413582710846786420
	.quad	-60105885123121412
	.quad	-7176018221920323369
	.quad	-75132356403901765
	.quad	-4358336758973016307
	.quad	9129456591349898602
	.quad	-836234930288882479
	.quad	-1211618658047395230
	.quad	-7440175859071633406
	.quad	-6126209340986631941
	.quad	-4688533805412153853
	.quad	-7657761676233289927
	.quad	-1248981238337804412
	.quad	-2480258038432112252
	.quad	-7698142301602209614
	.quad	-7712008566467528219
	.quad	-5010991858575374113
	.quad	8806733365625141342
	.quad	-1652053804791829737
	.quad	-6025006692552756421
	.quad	-7950062655635975442
	.quad	6303799689591218186
	.quad	-5325892301117581398
	.quad	-1343622424865753076
	.quad	-2045679357969588844
	.quad	1466078993672598280
	.quad	-8196078626372074883
	.quad	6444284760518135753
	.quad	-5633412264537705700
	.quad	8055355950647669692
	.quad	-2430079312244744221
	.quad	2728754459941099605
	.quad	-8436328597794046994
	.quad	-5812428961928401301
	.quad	-5933724728815170839
	.quad	1957835834444274181
	.quad	-2805469892591575644
	.quad	-7999724640327104445
	.quad	-8670947710510816634
	.quad	3835402254873283156
	.quad	-6226998619711132888
	.quad	4794252818591603945
	.quad	-3172062256211528206
	.quad	7608094030047140370
	.quad	-8900067937773286985
	.quad	4898431519131537558
	.quad	-6513398903789220827
	.quad	-7712018656367741764
	.quad	-3530062611309138130
	.quad	2097517367411243254
	.quad	-9123818159709293187
	.quad	7233582727691441971
	.quad	-6793086681209228580
	.quad	9041978409614302463
	.quad	-3879672333084147821
	.quad	6690786993590490175
	.quad	-237904397927796872
	.quad	4181741870994056360
	.quad	-7066219276345954901
	.quad	615491320315182545
	.quad	-4221088077005055722
	.quad	-8454007886460797626
	.quad	-664674077828931749
	.quad	3939617107816777292
	.quad	-7332950326284164199
	.quad	-8910536670511192098
	.quad	-4554501889427817345
	.quad	7308573235570561494
	.quad	-1081441343357383777
	.quad	-6961356773836868826
	.quad	-7593429867239446717
	.quad	-8701695967296086033
	.quad	-4880101315621920492
	.quad	-6265433940692719637
	.quad	-1488440626100012711
	.quad	695789805494438131
	.quad	-7847804418953589800
	.quad	869737256868047664
	.quad	-5198069505264599346
	.quad	-8136200465769716229
	.quad	-1885900863153361279
	.quad	-473439272678684739
	.quad	-8096217067111932656
	.quad	4019886927579031981
	.quad	-5508585315462527915
	.quad	-8810199395808373736
	.quad	-2274045625900771990
	.quad	-7812217631593927537
	.quad	-8338807543829064350
	.quad	4069786015789754291
	.quad	-5811823411358942533
	.quad	475546501309804959
	.quad	-2653093245771290262
	.quad	4908902581746016004
	.quad	-8575712306248138270
	.quad	-3087243809672255804
	.quad	-6107954364382784934
	.quad	-8470740780517707659
	.quad	-3023256937051093263
	.quad	-682526969396179382
	.quad	-8807064613298015146
	.quad	-5464844730172612132
	.quad	-6397144748195131028
	.quad	-2219369894288377261
	.quad	-3384744916816525881
	.quad	-1387106183930235788
	.quad	-9032994600651410532
	.quad	2877803288514593169
	.quad	-6679557232386875260
	.quad	3597254110643241461
	.quad	-3737760522056206171
	.quad	9108253656731439730
	.quad	-60514634142869810
	.quad	1080972517029761927
	.quad	-6955350673980375487
	.quad	5962901664714590313
	.quad	-4082502324048081455
	.quad	-6381430974388925821
	.quad	-491441886632713915
	.quad	-8600080377420466542
	.quad	-7224680206786528053
	.quad	7696643601933968438
	.quad	-4419164240055772162
	.quad	397432465562684740
	.quad	-912269281642327298
	.quad	-4363290727450709941
	.quad	-7487697328667536418
	.quad	8380944645968776285
	.quad	-4747935642407032618
	.quad	1252808770606194548
	.quad	-1323233534581402868
	.quad	-8440366555225904215
	.quad	-7744549986754458649
	.quad	7896285879677171347
	.quad	-5069001465015685407
	.quad	-3964700705685699528
	.quad	-1724565812842218855
	.quad	2133748077373825699
	.quad	-7995382660667468640
	.quad	2667185096717282124
	.quad	-5382542307406947896
	.quad	3333981370896602654
	.quad	-2116491865831296966
	.quad	6695424375237764563
	.quad	-8240336443785642460
	.quad	8369280469047205704
	.quad	-5688734536304665171
	.quad	-3373457468973156582
	.quad	-2499232151953443560
	.quad	-9025939945749304720
	.quad	-8479549122611984081
	.quad	7164319141522920716
	.quad	-5987750384837592197
	.quad	4343712908476262991
	.quad	-2873001962619602342
	.quad	7326506586225052274
	.quad	-8713155254278333320
	.quad	9158133232781315342
	.quad	-6279758049420528746
	.quad	2224294504121868369
	.quad	-3238011543348273028
	.quad	-7833187971778608077
	.quad	-8941286242233752499
	.quad	-568112927868484288
	.quad	-6564921784364802720
	.quad	3901544858591782543
	.quad	-3594466212028615495
	.quad	-4479063491021217766
	.quad	-9164070410158966541
	.quad	-5598829363776522208
	.quad	-6843401994271320272
	.quad	-2386850686293264856
	.quad	-3942566474411762436
	.quad	1628122660560806834
	.quad	-316522074587315140
	.quad	-8205795374004271537
	.quad	-7115355324258153819
	.quad	-1033872180650563613
	.quad	-4282508136895304370
	.quad	-5904026244240592420
	.quad	-741449152691742558
	.quad	-5995859411864064214
	.quad	-7380934748073420955
	.quad	1728547772024695540
	.quad	-4614482416664388289
	.quad	-2451001303396518479
	.quad	-1156417002403097458
	.quad	5385653213018257807
	.quad	-7640289654143017767
	.quad	-7102991539009341454
	.quad	-4938676049251384305
	.quad	-8878739423761676818
	.quad	-1561659043136842477
	.quad	3674159897003727797
	.quad	-7893565929601608404
	.quad	4592699871254659746
	.quad	-5255271393574622601
	.quad	1129188820640936779
	.quad	-1957403223540890347
	.quad	3011586022114279439
	.quad	-8140906042354138323
	.quad	8376168546070237203
	.quad	-5564446534515285000
	.quad	-7976533391121755113
	.quad	-2343872149716718346
	.quad	1932195658189984911
	.quad	-8382449121214030822
	.quad	-6808127464117294670
	.quad	-5866375383090150624
	.quad	-3898473311719230433
	.quad	-2721283210435300376
	.quad	9092669226243950739
	.quad	-8618331034163144591
	.quad	-2469221522477225288
	.quad	-6161227774276542835
	.quad	6136845133758244198
	.quad	-3089848699418290639
	.quad	-3082000819042179232
	.quad	-8848684464777513506
	.quad	-8464187042230111944
	.quad	-6449169562544503978
	.quad	3254824252494523782
	.quad	-3449775934753242068
	.quad	-7189106879045698444
	.quad	-9073638986861858149
	.quad	-8986383598807123056
	.quad	-6730362715149934782
	.quad	2602078556773259892
	.quad	-3801267375510030573
	.quad	-1359087822460813039
	.quad	-139898200960150313
	.quad	-849429889038008149
	.quad	-7004965403241175802
	.quad	-5673473379724898090
	.quad	-4144520735624081848
	.quad	-2480155706228734709
	.quad	-568964901102714406
	.quad	-3855940325606653145
	.quad	-7273132090830278360
	.quad	-208239388580928527
	.quad	-4479729095110460046
	.quad	-4871985254153548563
	.quad	-987975350460687153
	.quad	-3044990783845967852
	.quad	-7535013621679011327
	.quad	5417133557047315993
	.quad	-4807081008671376254
	.quad	-2451955090545630817
	.quad	-1397165242411832414
	.quad	-3838314940804713212
	.quad	-7790757304148477115
	.quad	4425478360848884292
	.quad	-5126760611758208489
	.quad	920161932633717461
	.quad	-1796764746270372707
	.quad	2880944217109767366
	.quad	-8040506994060064798
	.quad	-5622191765467566601
	.quad	-5438947724147693094
	.quad	6807318348447705460
	.quad	-2186998636757228463
	.quad	-2662955059861265943
	.quad	-8284403175614349646
	.quad	-7940379843253970333
	.quad	-5743817951090549153
	.quad	8521269269642088700
	.quad	-2568086420435798537
	.quad	-6203421752542164322
	.quad	-8522583040413455942
	.quad	6080780864604458309
	.quad	-6041542782089432023
	.quad	-6234081974526590826
	.quad	-2940242459184402125
	.quad	5327070802775656542
	.quad	-8755180564631333184
	.quad	6658838503469570677
	.quad	-6332289687361778576
	.quad	8323548129336963346
	.quad	-3303676090774835316
	.quad	-4021154456019173716
	.quad	-8982326584375353929
	.quad	-5026443070023967146
	.quad	-6616222212041804507
	.quad	2940318199324816876
	.quad	-3658591746624867729
	.quad	8755227902219092404
	.quad	-9204148869281624187
	.quad	-2891023177508298208
	.quad	-6893500068174642330
	.quad	-8225464990312760664
	.quad	-4005189066790915008
	.quad	-5670145219463562926
	.quad	-394800315061255856
	.quad	7985374283903742932
	.quad	-7164279224554366766
	.quad	758345818024902857
	.quad	-4343663012265570553
	.quad	-3663753745896259333
	.quad	-817892746904575288
	.quad	-9207375118826243939
	.quad	-7428711994456441411
	.quad	-2285846861678029116
	.quad	-4674203974643163860
	.quad	1754377441329851509
	.quad	-1231068949876566920
	.quad	1096485900831157193
	.quad	-7686947121313936181
	.quad	-3241078642388441413
	.quad	-4996997883215032323
	.quad	5172023733869224042
	.quad	-1634561335591402499
	.quad	5538357842881958978
	.quad	-7939129862385708418
	.quad	-2300424733252327085
	.quad	-5312226309554747619
	.quad	6347841120289366951
	.quad	-2028596868516046619
	.quad	6273243709394548297
	.quad	-8185402070463610993
	.quad	3229868618315797467
	.quad	-5620066569652125837
	.quad	-574350245532641070
	.quad	-2413397193637769393
	.quad	-358968903457900669
	.quad	-8425902273664687727
	.quad	8774660907532399972
	.quad	-5920691823653471754
	.quad	1744954097560724157
	.quad	-2789178761139451788
	.quad	-8132775725879323210
	.quad	-8660765753353239224
	.quad	-5554283638921766109
	.quad	-6214271173264161126
	.quad	6892203506629956076
	.quad	-3156152948152813503
	.quad	-2609901835997359308
	.quad	-8890124620236590296
	.quad	1349308723430688769
	.quad	-6500969756868349965
	.quad	-2925050114139026943
	.quad	-3514526177658049553
	.quad	-1828156321336891839
	.quad	-9114107888677362827
	.quad	6938176635183661009
	.quad	-6780948842419315629
	.quad	4061034775552188357
	.quad	-3864500034596756632
	.quad	5076293469440235446
	.quad	-218939024818557886
	.quad	7784369436827535058
	.quad	-7054365918152680535
	.quad	-4104596259247744890
	.quad	-4206271379263462765
	.quad	-5130745324059681112
	.quad	-646153205651940552

	.p2align	4, 0x0
_static_string_98e090712d66312f:
	.asciz	"HEAP_BUFFER_BYTES exceeded, increase with: `mojo -D HEAP_BUFFER_BYTES=4096`\n"

	.p2align	4, 0x0
_static_string_0d78baac08237ddb:
	.asciz	"a"

	.p2align	4, 0x0
_static_string_0dcb71a55f79a509:
	.asciz	"At: %s:%llu:%llu: Assert Error: %s\n"

	.p2align	4, 0x0
_static_string_f9c5d72f244f07d1:
	.asciz	"`Optional.value()` called on empty `Optional`. Consider using `if optional:` to check whether the `Optional` is empty before calling `.value()`, or use `.or_else()` to provide a default value."

	.p2align	4, 0x0
_static_string_c44bdff4074eecdb:
	.space	1

	.p2align	4, 0x0
_static_string_7f1562353e292282:
	.asciz	": "

	.p2align	4, 0x0
_static_string_a8d4ace0dc8d360e:
	.asciz	" "

	.p2align	4, 0x0
_static_string_31203c1a2bdb78cc:
	.asciz	"ABORT:"

	.p2align	4, 0x0
_static_string_bbe01a6a523daf15:
	.asciz	"\n"

	.p2align	4, 0x0
_static_string_021076ac7eeae71f:
	.asciz	"oss/modular/mojo/stdlib/std/ffi/__init__.mojo"

	.p2align	4, 0x0
_static_string_57a1f4424b341bb2:
	.asciz	"random_state"

.subsections_via_symbols
