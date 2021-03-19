import { filter } from 'common/collections';
import { decodeHtmlEntities, toTitleCase } from 'common/string';
import { Fragment } from 'inferno';
import { useBackend, useLocalState } from "../../backend";
import { Box, Button, Flex, Icon, LabeledList, ProgressBar, Section } from "../../components";

export const pda_medical = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    recordsList,
    records,
  } = data;

  if (records) {
    const {
      general,
      medical,
    } = records;

    return (
      <Box>
        <Section level={2} title="Общие данные">
          {general && (
            <LabeledList>
              <LabeledList.Item label="Ф.И">
                {general.name}
              </LabeledList.Item>
              <LabeledList.Item label="Пол">
                {general.sex}
              </LabeledList.Item>
              <LabeledList.Item label="Раса">
                {general.species}
              </LabeledList.Item>
              <LabeledList.Item label="Возраст">
                {general.age}
              </LabeledList.Item>
              <LabeledList.Item label="Должность">
                {general.rank}
              </LabeledList.Item>
              <LabeledList.Item label="Отпечаток">
                {general.fingerprint}
              </LabeledList.Item>
              <LabeledList.Item label="физ. состояние">
                {general.p_stat}
              </LabeledList.Item>
              <LabeledList.Item label="Псих. состояние">
                {general.m_stat}
              </LabeledList.Item>
            </LabeledList>
          ) || (
            <Box color="bad">
              Общие даннные потеряны!
            </Box>
          )}
        </Section>
        <Section level={2} title="Медицинские данные">
          {medical && (
            <LabeledList>
              <LabeledList.Item label="Группа крови">
                {medical.b_type}
              </LabeledList.Item>
              <LabeledList.Item label="Minor Disabilities">
                {medical.mi_dis}
              </LabeledList.Item>
              <LabeledList.Item label="Детали">
                {medical.mi_dis_d}
              </LabeledList.Item>
              <LabeledList.Item label="Major Disabilities">
                {medical.ma_dis}
              </LabeledList.Item>
              <LabeledList.Item label="Детали">
                {medical.ma_dis_d}
              </LabeledList.Item>
              <LabeledList.Item label="Аллергии">
                {medical.alg}
              </LabeledList.Item>
              <LabeledList.Item label="Детали">
                {medical.alg_d}
              </LabeledList.Item>
              <LabeledList.Item label="Current Disease">
                {medical.cdi}
              </LabeledList.Item>
              <LabeledList.Item label="Детали">
                {medical.cdi_d}
              </LabeledList.Item>
              <LabeledList.Item label="Важные заметки">
                {medical.notes}
              </LabeledList.Item>
            </LabeledList>
          ) || (
            <Box color="bad">
              Медицинские данные утеряны!
            </Box>
          )}
        </Section>
      </Box>
    );
  }

  return (
    <Section level={2} title="Select a record">
      {recordsList.map(record => (
        <Button
          key={record.ref}
          icon="eye"
          fluid
          content={record.Name}
          onClick={() => act("Records", { target: record.ref })} />
      ))}
    </Section>
  );
};