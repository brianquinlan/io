import 'dart:convert';
import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart' as ffi2;
import 'package:stdlibc/stdlibc.dart' as libc;

//import 'package:posix/posix.dart' as posix;

/*
  _pwrite ??= Libc().dylib.lookupFunction<
      ffi.Int64 Function(
          ffi.Int32, ffi.Pointer<ffi.Int8>, ffi.Uint64, ffi.Int64),
      _dart_pwrite>('write');
*/
/*
typedef _fn = int Function(int fd, int cmd, int val);

typedef _dart_write = int Function(
  int __fd,
  ffi.Pointer<ffi.Void> __buf,
  int __nbyte,
);
final foo = ffi.DynamicLibrary.process();
final write2 = foo.lookupFunction<
    ffi.Int64 Function(ffi.Int32, ffi.Pointer<ffi.Void>, ffi.Uint64),
    _dart_write>('write');

int fcntl = foo.lookupFunction<
    ffi.Int64 Function(ffi.Int32, ffi.Pointer<ffi.Void>, ffi.Uint64),
    _dart_write>('write');
*/
abstract interface class TextWriter {
  Encoding get encoding;

  int write(String s);
}

mixin Foo on TextWriter {}

class Stdout implements TextWriter {
  @override
  Encoding encoding = utf8;

  // Return characters written or bytes?
  @override
  int write(String s) {
//    int flags = libc.fcntl(1, libc.F_GETFL, 0);

    //   final c = ffi2.malloc<ffi.Uint8>(1024);
    final bytes = encoding.encoder.convert(s);

    return libc.write(1, bytes);

//    c.asTypedList(1024).setAll(0, bytes);
//    return write2(1, c.cast(), bytes.length);
  }
}

Stdout get stdout => Stdout();
