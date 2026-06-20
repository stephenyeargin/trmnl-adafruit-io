function transform(input) {
  const { IDX_0, IDX_1 } = input;
  return {
    IDX_0: {
      name: IDX_0?.name
    },
    IDX_1: {
      data: IDX_1?.data
    }
  };
}
